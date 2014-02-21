require 'spec_helper'

describe 'account information' do
  it 'returns the rate limit when requested' do
    cassette('account1') do
      status = harvest.account.rate_limit_status
      status.max_calls.should == 500
    end
  end
  
  it 'returns the result of whoami' do
    cassette('account2') do
      user = harvest.account.who_am_i
      user.email.should == credentials["username"]
    end
  end
end
