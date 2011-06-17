require 'spec_helper'

describe Harvest::TimeEntry do
  context '#as_json' do
    it 'builds a specialized hash' do
      entry = Harvest::TimeEntry.new(:notes => 'the notes', :project_id => 'the project id', :task_id => 'the task id', :hours => 'the hours', :spent_at => '12/28/2009')
      entry.as_json.should == {"notes" => "the notes", "hours" => "the hours", "project_id" => "the project id", "task_id" => "the task id", "spent_at" => "2009-12-28T00:00:00-05:00"}
    end
  end
  
  context "#spent_at" do
    it "should parse strings" do
      entry = Harvest::TimeEntry.new(:spent_at => "12/01/2009")
      entry.spent_at.should == Time.parse("12/01/2009")
    end
    
    it "should accept times" do
      entry = Harvest::TimeEntry.new(:spent_at => Time.parse("12/01/2009"))
      entry.spent_at.should == Time.parse("12/01/2009")
    end
  end
end
