require 'spec_helper'

describe 'harvest users' do
  it "allows adding, updating, and removing users" do
    cassette("users") do
      user = harvest.users.create(
        "first_name"            => "Edgar",
        "last_name"             => "Ruth",
        "email"                 => "edgar@ruth.com",
        "timezone"              => "cst",
        "is_admin"                 => "false",
        "telephone"             => "444-4444"
      )
      user.id.should_not be_nil

      user.first_name = "Joey"
      user = harvest.users.update(user)
      user.first_name.should == "Joey"

      id = harvest.users.delete(user)
      harvest.users.all.map(&:id).should_not include(id)
    end
  end

  it "allows activating and deactivating users" do
    cassette("users2") do
      user = harvest.users.create(
        "first_name"            => "John",
        "last_name"             => "Ruth",
        "email"                 => "john@ruth.com",
        "timezone"              => "cst",
        "is_admin"              => "false",
        "telephone"             => "444-4444"
      )
      user.should be_active

      user = harvest.users.deactivate(user)
      user.should_not be_active

      user = harvest.users.activate(user)
      user.should be_active

      harvest.users.delete(user)
    end
  end

  context "assignments" do
    it "allows adding, updating, and removing users from projects" do
      cassette('users4') do
        client      = harvest.clients.create(
          "name"    => "Joe's Steam Cleaning w/Users",
          "details" => "Building API Widgets across the country"
        )

        project       = harvest.projects.create(
          "name"      => "Test Project w/User",
          "active"    => true,
          "notes"     => "project to test the api",
          "client_id" => client.id
        )

        user = harvest.users.create(
          "first_name"            => "Sally",
          "last_name"             => "Ruth",
          "email"                 => "sally@ruth.com",
          "password"              => "mypassword",
          "timezone"              => "cst",
          "is_admin"              => "false",
          "telephone"             => "444-4444"
        )


        assignment = harvest.user_assignments.create("project" => project, "user" => user)

        assignment.hourly_rate = 100
        assignment = harvest.user_assignments.update(assignment)
        assignment.hourly_rate.should == 100.0

        harvest.user_assignments.delete(assignment)
        all_assignments = harvest.user_assignments.all(project)
        all_assignments.size.should == 1
      end
    end
  end
end
