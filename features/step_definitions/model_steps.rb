When /^I create a (client|task|user) with the following:$/ do |type, table|
  case type
  when "client"
    client = Harvest::Client.new(table.rows_hash)
    harvest_api.clients.create(client)
  when "task"
    task = Harvest::Task.new(table.rows_hash)
    harvest_api.tasks.create(task)
  when "user"
    user = Harvest::User.new(table.rows_hash)
    harvest_api.users.create(user)
  end
end

When /^I create a (contact|project) for the client "([^\"]*)" with the following:$/ do |type, client_name, table|
  client = Then %Q{there should be a client "#{client_name}"}
  attributes = table.rows_hash.merge("client_id" => client.id)
  
  case type
  when "contact"
    contact = Harvest::Contact.new(attributes)
    harvest_api.contacts.create(contact)
  when "project"
    project = Harvest::Project.new(attributes)
    harvest_api.projects.create(project)
  end
end

Then /^there should be a (contact|project|client|task|user) "([^\"]*)"$/ do |type, identifier|
  collection = harvest_api.send(pluralize(type)).all
  attribute = case type
  when 'contact', 'user' then 'email'
  when 'project', 'client', 'task' then 'name'
  end
  item = collection.detect {|c| c.send(attribute) == identifier}
  item.should_not be_nil
  item
end

Then /^there should not be a (contact|project|client|task|user) "([^\"]*)"$/ do |type, identifier|
  collection = harvest_api.send(pluralize(type)).all
  attribute = case type
  when 'contact', 'user' then 'email'
  when 'project', 'client', 'task' then 'name'
  end
  item = collection.detect {|c| c.send(attribute) == identifier}
  item.should be_nil
end

When /^I update the (contact|project|client|task|user) "([^\"]*)" with the following:$/ do |type, name, table|
  item = Then %Q{there should be a #{type} "#{name}"}
  item.attributes = table.rows_hash
  harvest_api.send(pluralize(type)).update(item)
end

Then /^the (contact|project|client|task|user) "([^\"]*)" should have the following attributes:$/ do |type, name, table|
  item = Then %Q{there should be a #{type} "#{name}"}
  table.rows_hash.each do |key, value|
    item.send(key).to_s.should == value
  end
end

When /^I delete the (contact|project|client|task|user) "([^\"]*)"$/ do |type, name|
  item = Then %Q{there should be a #{type} "#{name}"}
  id = harvest_api.send(pluralize(type)).delete(item)
  id.should == item.id
end

Then /^the (client|project|user) "([^\"]*)" should be activated$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  item.should be_active
end

Then /^the (client|project|user) "([^\"]*)" should be deactivated$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  item.should_not be_active
end

When /^I deactivate the (client|project|user) "([^\"]*)"$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  harvest_api.send(pluralize(type)).deactivate(item)
end

When /^I activate the (client|project|user) "([^\"]*)"$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  harvest_api.send(pluralize(type)).activate(item)
end