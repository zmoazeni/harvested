require 'spec_helper'

describe 'harvest time tracking' do
  it 'allows adding, updating and removing entries' do
    cassette("time_tracking1") do
      client = harvest.clients.create("name" => "Jane's Car Shop")
      project = harvest.projects.create("name" => "Tracking Project", "client_id" => client.id)
      harvest.projects.create_task(project, "A billable task")
      task = harvest.tasks.all.detect {|t| t.name == "A billable task"}
      
      entry = harvest.time.create(:notes => "Test api support", :hours => 3, :spent_at => "12/28/2009", :task_id => task.id, :project_id => project.id)
      entry.notes.should == "Test api support"
      
      entry.notes = "Upgraded to JSON"
      entry = harvest.time.update(entry)
      entry.notes.should == "Upgraded to JSON"
      
      harvest.time.delete(entry)
      harvest.time.all.should == []
    end
  end
  
  it 'allows toggling of timers'
  
  it 'allows you to save a timer for a different user (of_user?)'
end