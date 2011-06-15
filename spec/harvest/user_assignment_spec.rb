require 'spec_helper'

describe Harvest::UserAssignment do
  describe "#user_as_json" do
    it "should generate the xml for existing users" do
      assignment = Harvest::UserAssignment.new(:user => mock(:user, :to_i => 3))
      assignment.user_as_json.should == {"user" => {"id" => 3}}
    end
  end
end