require 'spec_helper'

describe 'harvest time tracking' do
  it 'allows adding, updating and removing entries' do
    cassette("time_tracking1") do
      client = harvest.clients.create("name" => "Jane's Car Shop")
      project = harvest.projects.create("name" => "Tracking Project", "client_id" => client.id)
      harvest.projects.create_task(project, "A billable task")
      task = harvest.tasks.all.detect {|t| t.name == "A billable task"}

      entry = harvest.time.create("notes" => "Test api support", "hours" => 3, "spent_at" => "2009/12/28", "task_id" => task.id, "project_id" => project.id)
      entry.notes.should == "Test api support"

      entry.notes = "Upgraded to JSON"
      entry = harvest.time.update(entry)
      entry.notes.should == "Upgraded to JSON"

      harvest.time.delete(entry)
      harvest.time.all(Time.utc(2009, 12, 28)).should == []
    end
  end

  it 'allows you to save entries for a different user' do
    cassette("time_tracking2") do
      user = harvest.users.create(
        "email"      => "frank@example.com",
        "first_name" => "Frank",
        "last_name"  => "Doe",
        "password"   => "secure"
      )
      client = harvest.clients.create("name" => "Kim's Tux Shop")
      project = harvest.projects.create("name" => "Other User Tracking Project", "client_id" => client.id)
      harvest.user_assignments.create("project" => project, "user" => user)
      harvest.projects.create_task(project, "A billable task for tuxes")
      task = harvest.tasks.all.detect {|t| t.name == "A billable task for tuxes"}

      entry = harvest.time.create("notes" => "Test api support", "hours" => 3, "spent_at" => "2009/12/28", "task_id" => task.id, "project_id" => project.id, "of_user" => user.id)
      harvest.time.all(Time.utc(2009, 12, 28), user).should == [entry]

      entry.notes = "Updating notes"
      entry = harvest.time.update(entry, user)
      entry.notes.should == "Updating notes"

      entry = harvest.time.find(entry, user)
      entry.notes.should == "Updating notes"

      harvest.time.delete(entry, user)
      harvest.time.all(Time.utc(2009, 12, 28), user).should == []
    end
  end

  it 'allows toggling of timers'

  it 'allows retrieving trackable projects and tasks' do
    cassette("time_tracking3") do
      client = harvest.clients.create("name" => "Bobbys Coffee Shop")
      project = harvest.projects.create("name" => "Bobby's Trackable Project", "client_id" => client.id)
      harvest.projects.create_task(project, "A billable task for Bobby")

      trackable_projects = harvest.time.trackable_projects
      trackable_project = trackable_projects.find {|p| p.name == "Bobby's Trackable Project" }
      trackable_projects.first.client.should == "Bobbys Coffee Shop"
      trackable_projects.first.tasks.first.name.should == "A billable task for Bobby"
    end
  end

  it 'allows for absence of trackable projects' do
    cassette("time_tracking4") do
      user = harvest.users.create(
        "email"      => "gary@example.com",
        "first_name" => "Gary",
        "last_name"  => "Doe",
        "password"   => "secure"
      )

      trackable_projects = harvest.time.trackable_projects(Time.now, user)
      trackable_projects.should == []
    end
  end
end
