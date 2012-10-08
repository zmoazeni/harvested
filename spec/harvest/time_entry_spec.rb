require 'spec_helper'

describe Harvest::TimeEntry do
  context '#as_json' do
    it 'builds a specialized hash' do
      entry = Harvest::TimeEntry.new(:notes => 'the notes', :project_id => 'the project id', :task_id => 'the task id', :hours => 'the hours', :spent_at => Time.utc(2009, 12, 28))
      entry.as_json.should == {"notes" => "the notes", "hours" => "the hours", "project_id" => "the project id", "task_id" => "the task id", "spent_at" => "2009-12-28"}
    end
  end
  
  context "#spent_at" do
    it "should parse strings" do
      date = RUBY_VERSION =~ /1.8/ ? "12/01/2009" : "01/12/2009"
      entry = Harvest::TimeEntry.new(:spent_at => date)
      entry.spent_at.should == Date.parse(date)
    end
    
    it "should accept times" do
      entry = Harvest::TimeEntry.new(:spent_at => Time.utc(2009, 12, 1))
      entry.spent_at.should == Date.new(2009, 12, 1)
    end
  end
end
