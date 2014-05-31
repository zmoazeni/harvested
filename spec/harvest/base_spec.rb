require 'spec_helper'

describe Harvest::Base do
  describe "username/password errors" do
    it "should raise error if missing a credential" do
      lambda { Harvest::Base.new(subdomain: "subdomain", password: "secure") }.should raise_error(/must provide either/i)
    end
  end
end
