require 'spec_helper'

describe 'harvest time tracking' do
  it 'allows adding, updating and removing entries' do
    cassette("time_tracking1") do
      client = harvest.clients.find_or_create_by_name("Jane's Car Shop")
      begin
        project = harvest.projects.create("name" => "Tracking Project", "client_id" => client.id)
      rescue Harvest::BadRequest
        project = harvest.projects.all.detect {|p| p.name == "Tracking Project" && p.client_id = client.id}
      end

      if task = harvest.tasks.all.detect {|t| t.name == "A billable task"}
        harvest.tasks.delete(task.id)
      else
        task = harvest.tasks.create(:name => "A billable task")
      end

      harvest.tasks.activate(task.id)
      harvest.task_assignments.create("project" => project, "task" => task)

      entry = harvest.time.create("notes" => "Test api support", "hours" => 3, "spent_at" => "2009/12/28", "task_id" => task.id, "project_id" => project.id)
      entry.notes.should == "Test api support"

      entry.notes = "Upgraded to JSON"
      entry = harvest.time.update(entry)
      entry.notes.should == "Upgraded to JSON"

      harvest.time.delete(entry)
      harvest.time.all(Time.utc(2009, 12, 28)).detect {|t| t.id == entry.id}.should == nil
    end
  end

  it 'allows you to save entries for a different user' do
    cassette("time_tracking2") do
      begin
        user = harvest.users.create(
          "email"      => "frank@example.com",
          "first_name" => "Frank",
          "last_name"  => "Doe",
          "password"   => "secure"
        )
      rescue Harvest::BadRequest
        user = harvest.users.all.detect {|u| u.email == "frank@example.com"}
      end

      client = harvest.clients.find_or_create_by_name("Kim's Tux Shop")

      begin
        project = harvest.projects.create("name" => "Other User Tracking Project", "client_id" => client.id)
      rescue Harvest::BadRequest
        project = harvest.projects.all.detect {|p| p.name == "Other User Tracking Project" && p.client_id = client.id}
      end
      
      harvest.user_assignments.create("project" => project, "user" => user)
      harvest.projects.create_task(project, "A billable task for tuxes")
      task = harvest.tasks.all.detect{|t| t.name == "A billable task for tuxes"}
      harvest.tasks.activate(task.id)

      entry = harvest.time.create("notes" => "Test api support", "hours" => 3, "spent_at" => "2009/12/28", "task_id" => task.id, "project_id" => project.id, "of_user" => user.id)

      harvest.time.all(Time.utc(2009, 12, 28), user).detect{|t| t.id == entry.id}.should == entry

      entry.notes = "Updating notes"
      entry = harvest.time.update(entry, user)
      entry.notes.should == "Updating notes"

      entry = harvest.time.find(entry, user)
      entry.notes.should == "Updating notes"

      harvest.time.delete(entry, user)
      harvest.time.all(Time.utc(2009, 12, 28), user).detect{|t| t.id == entry.id}.should == nil
    end
  end

  it 'allows toggling of timers'
end
