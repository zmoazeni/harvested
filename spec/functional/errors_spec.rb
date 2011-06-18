require 'spec_helper'

describe 'harvest errors' do
  before { WebMock.disable_net_connect! }
  
  it "wraps errors" do
    stub_request(:get, /\/clients/).to_return({:status => ['400', 'Bad Request']}, {:body => "[]", :status => 200})
    expect { harvest.clients.all }.to raise_error(Harvest::BadRequest)
    
    stub_request(:get, /\/clients/).to_return({:status => ['404', 'Not Found']}, {:body => "[]", :status => 200})
    expect { harvest.clients.all }.to raise_error(Harvest::NotFound)
    
    stub_request(:get, /\/clients/).to_return({:status => ['500', 'Server Error']}, {:body => "[]", :status => 200})
    expect { harvest.clients.all }.to raise_error(Harvest::ServerError)
    
    stub_request(:get, /\/clients/).to_return({:status => ['502', 'Bad Gateway']}, {:body => "[]", :status => 200})
    expect { harvest.clients.all }.to raise_error(Harvest::Unavailable)
    
    stub_request(:get, /\/clients/).to_return({:status => ['503', 'Rate Limited']}, {:body => "[]", :status => 200})
    expect { harvest.clients.all }.to raise_error(Harvest::RateLimited)
  end
end