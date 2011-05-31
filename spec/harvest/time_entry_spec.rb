require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Harvest::TimeEntry do
  describe "#to_xml" do
    it "should build a valid request xml" do
      entry = Harvest::TimeEntry.new(:notes => 'the notes', 
                                     :project_id => 'the project id', 
                                     :task_id => 'the task id', 
                                     :hours => 'the hours', 
                                     :spent_at => '12/28/2009')
      entry.to_xml.should == '<request><notes>the notes</notes><hours>the hours</hours><project_id>the project id</project_id><task_id>the task id</task_id><spent_at>2009-12-28 00:00:00 -0800</spent_at></request>'
    end
  end
  
  describe "#spent_at" do
    it "should parse strings" do
      entry = Harvest::TimeEntry.new(:spent_at => "12/01/2009")
      entry.spent_at.should == Time.strptime("12/01/2009",'%m/%d/%Y')
    end
    
    it "should accept times" do
      entry = Harvest::TimeEntry.new(:spent_at => Time.strptime("12/01/2009",'%m/%d/%Y'))
      entry.spent_at.should == Time.strptime("12/01/2009",'%m/%d/%Y')
    end
  end
end
