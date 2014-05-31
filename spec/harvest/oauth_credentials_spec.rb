require 'spec_helper'

describe Harvest::OAuthCredentials do
  context '#set_authentication' do
    it "should set the access token in the query" do
      credentials = Harvest::OAuthCredentials.new('theaccesstoken')
      credentials.set_authentication(options = {})
      options[:query]['access_token'].should == 'theaccesstoken'
    end
  end
end
