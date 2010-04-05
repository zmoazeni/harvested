require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Harvest::PersonAssignment do
  describe "#person_xml" do
    it "should generate the xml for existing persons" do
      assignment = Harvest::PersonAssignment.new(:person => mock(:person, :to_i => 3))
      assignment.person_xml.should == '<user><id>3</id></user>'
    end
  end
end