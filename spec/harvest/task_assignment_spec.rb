require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Harvest::TaskAssignment do
  describe "#task_xml" do
    it "should generate the xml for existing tasks" do
      assignment = Harvest::TaskAssignment.new(:task => mock(:task, :to_i => 3))
      assignment.task_xml.should == '<task><id>3</id></task>'
    end
  end
end