require 'spec_helper'

describe Harvest::Project do
  it_behaves_like 'a json sanitizer', %w(hint_latest_record_at hint_earliest_record_at cache_version)
    
  it "cleans up weird attributes" do
    project = Harvest::Project.parse('[{"project":{"hint-earliest-record-at":10, "hint-latest-record-at":20}}]').first
    project.hint_earliest_record_at.should == 10
    project.hint_latest_record_at.should == 20
  end
end