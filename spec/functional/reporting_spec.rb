require 'spec_helper'

describe 'harvest reporting' do
  it 'project and people entry reporting' do
    cassette("reports1") do
      user = harvest.users.create(
        "email"      => "jane@example.com",
        "first_name" => "Jane",
        "last_name"  => "Doe",
        "password"   => "secure"
      )
      client   = harvest.clients.create("name" => "Tim's Dry Cleaning")
      project1 = harvest.projects.create("name" => "Reporting Project1", "client_id" => client.id)
      project2 = harvest.projects.create("name" => "Reporting Project2", "client_id" => client.id)
      task1     = harvest.tasks.create("name" => "A billable task", "default_hourly_rate" => 120, "billable_by_default" => true)
      task2     = harvest.tasks.create("name" => "A non billable task", "billable_by_default" => false)

      harvest.task_assignments.create("project" => project1, "task" => task1)
      harvest.task_assignments.create("project" => project2, "task" => task2)
      harvest.user_assignments.create("project" => project1, "user" => user)
      harvest.user_assignments.create("project" => project2, "user" => user)

      entry1 = harvest.time.create("notes" => "billable entry1", "hours" => 3, "spent_at" => "12/28/2009", "task_id" => task1.id, "project_id" => project1.id, "of_user" => user.id)
      entry2 = harvest.time.create("notes" => "non billable entry2", "hours" => 6, "spent_at" => "12/28/2009", "task_id" => task2.id, "project_id" => project2.id, "of_user" => user.id)

      harvest.reports.time_by_project(project1, Time.parse("12/20/2009"), Time.parse("12/30/2009")).should == [entry1]

      harvest.reports.time_by_project(project1, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :user => user).should == [entry1]

      harvest.reports.time_by_project(project2, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :user => user).should == [entry2]

      harvest.reports.time_by_project(project2, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :billable => true).should == []
      harvest.reports.time_by_project(project2, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :billable => false).should == [entry2]

      harvest.reports.time_by_user(user, Time.parse("12/20/2009"), Time.parse("12/30/2009")).map(&:id).should == [entry1, entry2].map(&:id)

      harvest.reports.time_by_user(user, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :project => project1).should == [entry1]

      harvest.reports.time_by_user(user, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :project => project2).should == [entry2]

      harvest.reports.time_by_user(user, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :billable => true).should == [entry1]
      harvest.reports.time_by_user(user, Time.parse("12/20/2009"), Time.parse("12/30/2009"), :billable => false).should == [entry2]
    end
  end


  it 'expense reporting' do
    cassette("reports2") do
      user = harvest.users.create(
        "email"      => "simon@example.com",
        "first_name" => "Simon",
        "last_name"  => "Stir",
        "password"   => "secure"
      )

      category = harvest.expense_categories.create("name" => "Reporting category", "unit_price" => 100, "unit_name"  => "deduction")
      client  = harvest.clients.create("name" => "Philip's Butcher")
      project = harvest.projects.create("name" => "Expense Reporting Project", "client_id" => client.id)
      harvest.user_assignments.create("project" => project, "user" => user)

      expense                 = harvest.expenses.create(
        "notes"               => "Drive to Chicago",
        "total_cost"          => 75.0,
        "spent_at"            => "12/28/2009",
        "expense_category_id" => category.id,
        "project_id"          => project.id,
        "user_id"             => user.id
      )
      
      harvest.reports.expenses_by_user(user, Time.parse("12/20/2009"), Time.parse("12/30/2009")).should == [expense]
      
      my_user = harvest.users.all.detect {|u| u.email == credentials["username"]}
      my_user.should_not be_nil
      harvest.reports.expenses_by_user(my_user, Time.parse("12/20/2009"), Time.parse("12/30/2009")).should == []
    end
  end
end
