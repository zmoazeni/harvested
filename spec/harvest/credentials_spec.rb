require 'spec_helper'

describe Harvest::Credentials do
  describe "#valid?" do
    it "should return true if domain, username, and password is filled out" do
      Harvest::Credentials.new("some-domain", "username", "password").should be_valid
    end
    
    it "should return false if either domain, username, or password is nil" do
      Harvest::Credentials.new("some-domain", "username", nil).should_not be_valid
      Harvest::Credentials.new("some-domain", nil, "password").should_not be_valid
      Harvest::Credentials.new(nil, "username", "password").should_not be_valid
      Harvest::Credentials.new(nil, nil, nil).should_not be_valid
    end
  end
  
  describe "#basic_auth" do
    it "should base64 encode the credentials" do
      Harvest::Credentials.new("some-domain", "username", "password").basic_auth.should == "dXNlcm5hbWU6cGFzc3dvcmQ="
    end
  end
end