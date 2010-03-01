require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Harvest do
  describe "username/password errors" do
    it "should raise error if missing a credential" do
      lambda { Harvest.new("subdomain", nil, "secure") }.should raise_error(Harvest::InvalidCredentials)
    end
  end
end
