require 'spec_helper'

describe 'harvest projects', :clean => true do
  it 'allows adding, updating and removing projects' do
    VCR.use_cassette('project1') do
      client      = harvest.clients.create(Harvest::Client.new(
        "name"    => "Joe's Steam Cleaning", 
        "details" => "Building API Widgets across the country"
      ))
    
      project       = harvest.projects.create(Harvest::Project.new(
        "name"      => "Test Project",
        "active"    => true,
        "notes"     => "project to test the api",
        "client_id" => client.id
      ))
      project.name.should == "Test Project"
    
      project.name = "Updated Project"
      project = harvest.projects.update(project)
      project.name.should == "Updated Project"
    
      harvest.projects.delete(project)
      harvest.projects.all.size.should == 0
    end
  end
  
  it 'allows activating and deactivating clients' do
    VCR.use_cassette('project2') do
      client      = harvest.clients.create(Harvest::Client.new(
        "name"    => "Joe's Steam Cleaning",
        "details" => "Building API Widgets across the country"))
      
      project       = harvest.projects.create(Harvest::Project.new(
        "name"      => "Test Project",
        "active"    => true,
        "notes"     => "project to test the api",
        "client_id" => client.id
      ))
      project.should be_active
    
      project = harvest.projects.deactivate(project)
      project.should_not be_active
    
      project = harvest.projects.activate(project)
      project.should be_active
    end
  end
end
