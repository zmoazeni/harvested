Given /^the next request will receive a (bad request|not found|bad gateway|server error|rate limit) response$/ do |type|
  statuses = {
    'bad request' => ['400', 'Bad Request'], 
    'not found' => ['404', 'Not Found'],
    'bad gateway' => ['502', 'Bad Gateway'],
    'server error' => ['500', 'Server Error'],
    'rate limit' => ['503', 'Rake Limited']
  }
  
  if status = statuses[type]
    FakeWeb.register_uri(:get, /\/clients/, :status => status)
  else
    pending
  end
end

Given /^the next request will receive a rate limit response with a refresh in (\d+) seconds$/ do |seconds|
  FakeWeb.register_uri(:get, /\/clients/, [
    {:status => ['503', 'Rake Limited'], "Retry-After" => seconds},
    {:body => File.read(File.dirname(__FILE__) + '/../support/fixtures/empty_clients.xml')}
  ])
end

When 'I make a request with the standard client' do
  @time = Time.now
  begin
    standard_api.clients.all
  rescue => e
    @error = e
  end
end

When 'I make a request with the robust client' do
  @time = Time.now
  harvest_api.clients.all
end

Then /a (\d+) error should be raised/ do |code|
  case code
  when '400'
    @error.should be_a(Harvest::BadRequest)
  when '404'
    @error.should be_a(Harvest::NotFound)
  when '502'
    @error.should be_a(Harvest::Unavailable)
  when '500'
    @error.should be_a(Harvest::InformHarvest)
  when '503'
    @error.should be_a(Harvest::RateLimited)
  else
    pending
  end
end

Then /the robust client should wait (\d+) seconds for the rate limit to reset/ do |seconds|
  Time.now.should be_close(@time + seconds.to_i, 2)
end

Then 'I should be able to make a request again' do
  harvest_api.clients.all
  harvest_api.clients.all
end