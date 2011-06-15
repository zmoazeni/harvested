require 'spec_helper'

describe 'account information' do
  it 'returns the rate limit when requested' do
    cassette('account') do
      status = harvest.account.rate_limit_status
      status.max_calls.should == 100
    end
  end
  
  it 'returns the result of whoami'
end
