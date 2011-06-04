require 'spec_helper'

describe 'account information', :clean => true do
  it 'returns the rate limit when requested' do
    VCR.use_cassette('account') do
      harvest.account.rate_limit_status.max_calls.should == 100
    end
  end
  
  it 'returns the result of whoami'
end
