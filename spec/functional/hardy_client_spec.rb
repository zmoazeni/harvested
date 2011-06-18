require 'spec_helper'

describe 'harvest hardy client' do
  before do 
    WebMock.disable_net_connect!
    @time = Time.now
  end
  
  it "waits the alloted time out when over rate limit" do
    stub_request(:get, /\/clients/).to_return({:status => ['503', 'Rate Limited'], :headers => {"Retry-After" => "5"}}, {:body => "[]", :status => 200})
    hardy_harvest.clients.all
    Time.now.should be_within(10).of(@time)
  end
  
  it "waits a default time when over the rate limit" do
    stub_request(:get, /\/clients/).to_return({:status => ['503', 'Rate Limited']}, {:body => "[]", :status => 200})
    hardy_harvest.clients.all
    Time.now.should be_within(20).of(@time)
  end
  
  it "retries after known errors" do
    stub_request(:get, /\/rate_limit_status/).to_return({:body => '{"lockout_seconds":2,"last_access_at":"2011-06-18T17:13:22+00:00","max_calls":100,"count":1,"timeframe_limit":15}'})
    
    stub_request(:get, /\/clients/).to_return({:status => ['502', 'Bad Gateway']}).times(2).then.to_return({:body => "[]", :status => 200})
    hardy_harvest.clients.all.should == []
    
    stub_request(:get, /\/clients/).to_raise(Net::HTTPError.new("custom error", "")).times(2).then.to_return({:body => "[]", :status => 200})
    hardy_harvest.clients.all.should == []
    
    stub_request(:get, /\/clients/).to_return({:status => ['502', 'Bad Gateway']}).times(6).then.to_return({:body => "[]", :status => 200})
    expect { hardy_harvest.clients.all }.to raise_error(Harvest::Unavailable)
  end
end