require 'spec_helper'

describe Harvest::TrackableProject do
  it "creates task objects" do
    projects = Harvest::TrackableProject.parse('[{"tasks":[{"id":123}]}]').first
    projects.tasks.first.id.should == 123
  end
end
