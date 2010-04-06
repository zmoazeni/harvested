require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Harvest::UserAssignment do
  describe "#user_xml" do
    it "should generate the xml for existing users" do
      assignment = Harvest::UserAssignment.new(:user => mock(:user, :to_i => 3))
      assignment.user_xml.should == '<user><id>3</id></user>'
    end
  end
end