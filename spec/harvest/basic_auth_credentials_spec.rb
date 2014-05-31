require 'spec_helper'

describe Harvest::BasicAuthCredentials do
  context '#set_authentication' do
    it "should set the headers Authorization" do
      credentials = Harvest::BasicAuthCredentials.new(subdomain: 'some-domain', username: 'username', password: 'password')
      credentials.set_authentication(options = {})
      options[:headers]['Authorization'].should == "Basic dXNlcm5hbWU6cGFzc3dvcmQ="
    end
  end
end
