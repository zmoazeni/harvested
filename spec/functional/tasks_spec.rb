require 'spec_helper'

describe 'harvest tasks' do
  it 'allows adding, updating and removing tasks' do
    cassette('tasks') do
      task            = harvest.tasks.create(
        "name"        => "A crud task",
        "billable_by_default"    => true,
        "default_hourly_rate"    => 120
      )
      task.default_hourly_rate.should == "120.0"

      task.default_hourly_rate = 140
      task = harvest.tasks.update(task)
      task.default_hourly_rate.should == "140.0"

      harvest.tasks.delete(task)
      harvest.tasks.all.select {|t| t.name == "A crud task"}.should == []
    end
  end

  context "task assignments" do
    it "allows adding, updating, and removing tasks from projects" do
      cassette('tasks2') do
        client = harvest.clients.create(FactoryGirl.attributes_for(:client))

        project       = harvest.projects.create(
          "name"      => "Test Project2",
          "active"    => true,
          "notes"     => "project to test the api",
          "client_id" => client.id
        )

        task1            = harvest.tasks.create(
          "name"                => "A task for joe",
          "billable_by_default" => true,
          "default_hourly_rate" => 120
        )
        
        # need to keep at least one task on the project
        task2            = harvest.tasks.create(
          "name"                => "A task for joe2",
          "billable_by_default" => true,
          "default_hourly_rate" => 100
        )
        
        harvest.task_assignments.create("project" => project, "task" => task1)
        harvest.task_assignments.create("project" => project, "task" => task2)
        
        all_assignments = harvest.task_assignments.all(project)
        assignment1 = all_assignments.detect {|a| a.task_id == task1.id }
        assignment2 = all_assignments.detect {|a| a.task_id == task2.id }
        
        assignment1.hourly_rate = 100
        assignment1 = harvest.task_assignments.update(assignment1)
        assignment1.hourly_rate.should == "100.0"

        harvest.task_assignments.delete(assignment1)
        all_assignments = harvest.task_assignments.all(project)
        all_assignments.size.should == 1
      end
    end

    it "allows creating and assigning the task at the same time" do
      cassette('tasks3') do
        client = harvest.clients.create(FactoryGirl.attributes_for(:client))

        project       = harvest.projects.create(
          "name"      => "Test Project3",
          "active"    => true,
          "notes"     => "project to test the api",
          "client_id" => client.id
        )

        project2 = harvest.projects.create_task(project, "A simple task")
        project2.should == project

        harvest.task_assignments.all(project).size.should == 1
      end
    end
  end
end
