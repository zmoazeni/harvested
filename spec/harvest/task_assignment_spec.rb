require 'spec_helper'

describe Harvest::TaskAssignment do
  context "task_as_json" do
    it "generates the json for existing tasks" do
      assignment = Harvest::TaskAssignment.new(:task => double(:task, :to_i => 3))
      assignment.task_as_json.should == {"task" => {"id" => 3}}
    end
  end
end
