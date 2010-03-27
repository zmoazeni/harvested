Given(/the next request will rate limit for (\d)+ seconds/) do |seconds|
  seconds = seconds.to_i
  Artifice.activate_with(FakeRateLimit.new(seconds))
end

When 'I hit the rate limit' do
  @time = Time.now
  harvest_api.clients.all
end

Then 'the API should wait for the rate limit to reset' do
  Time.now.should be_close(@time + 5, 2)
end

Then 'I should be able to make a request again' do
  harvest_api.clients.all
  harvest_api.clients.all
end