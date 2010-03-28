When 'I create a project for the client "$1" with the following:' do |name, table|
  client = Then %Q{there should be a client with the name "#{name}"}
  project = Harvest::Project.new(table.rows_hash.merge("client_id" => client.id))
  harvest_api.projects.create(project)
end

Then 'there should be a project "$1"' do |name|
  projects = harvest_api.projects.all
  project = projects.detect {|c| c.name == name}
  project.should_not be_nil
  project
end

Then 'there should not be a project "$1"' do |name|
  projects = harvest_api.projects.all
  project = projects.detect {|c| c.name == name}
  project.should be_nil
end

When 'I update the project "$1" with the following:' do |name, table|
  project = Then %Q{there should be a project "#{name}"}
  project.attributes = table.rows_hash
  harvest_api.projects.update(project)
end

Then 'the project "$1" should have the following attributes:' do |name, table|
  project = Then %Q{there should be a project "#{name}"}
  table.rows_hash.each do |key, value|
    project.send(key).to_s.should == value
  end
end

When 'I delete the project "$1"' do |name|
  project = Then %Q{there should be a project "#{name}"}
  id = harvest_api.projects.delete(project)
  id.should == project.id
end

Then 'the project "$1" should be activated' do |name|
  project = Then %Q{there should be a project "#{name}"}
  project.should be_active
end

Then 'the project "$1" should be deactivated' do |name|
  project = Then %Q{there should be a project "#{name}"}
  project.should_not be_active
end

When 'I deactivate the project "$1"' do |name|
  project = Then %Q{there should be a project "#{name}"}
  harvest_api.projects.deactivate(project)
end

When 'I activate the project "$1"' do |name|
  project = Then %Q{there should be a project "#{name}"}
  harvest_api.projects.activate(project)
end