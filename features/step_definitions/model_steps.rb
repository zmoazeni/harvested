When /^I create a (client|task) with the following:$/ do |type, table|
  case type
  when "client"
    client = Harvest::Client.new(table.rows_hash)
    harvest_api.clients.create(client)
  when "task"
    task = Harvest::Task.new(table.rows_hash)
    harvest_api.tasks.create(task)
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

Then /^there should be a (contact|project|client|task) "([^\"]*)"$/ do |type, identifier|
  collection = harvest_api.send("#{type}s").all
  attribute = case type
  when "contact" then "email"
  when "project", "client", "task" then "name"
  end
  item = collection.detect {|c| c.send(attribute) == identifier}
  item.should_not be_nil
  item
end

Then /^there should not be a (contact|project|client|task) "([^\"]*)"$/ do |type, identifier|
  collection = harvest_api.send("#{type}s").all
  attribute = case type
  when "contact" then "email"
  when "project", "client", "task" then "name"
  end
  item = collection.detect {|c| c.send(attribute) == identifier}
  item.should be_nil
end

When /^I update the (contact|project|client|task) "([^\"]*)" with the following:$/ do |type, name, table|
  item = Then %Q{there should be a #{type} "#{name}"}
  item.attributes = table.rows_hash
  harvest_api.send("#{type}s").update(item)
end

Then /^the (contact|project|client|task) "([^\"]*)" should have the following attributes:$/ do |type, name, table|
  item = Then %Q{there should be a #{type} "#{name}"}
  table.rows_hash.each do |key, value|
    item.send(key).to_s.should == value
  end
end

When /^I delete the (contact|project|client|task) "([^\"]*)"$/ do |type, name|
  item = Then %Q{there should be a #{type} "#{name}"}
  id = harvest_api.send("#{type}s").delete(item)
  id.should == item.id
end

Then /^the (client|project) "([^\"]*)" should be activated$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  item.should be_active
end

Then /^the (client|project) "([^\"]*)" should be deactivated$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  item.should_not be_active
end

When /^I deactivate the (client|project) "([^\"]*)"$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  harvest_api.send("#{type}s").deactivate(item)
end

When /^I activate the (client|project) "([^\"]*)"$/ do |type, identifier|
  item = Then %Q{there should be a #{type} "#{identifier}"}
  harvest_api.send("#{type}s").activate(item)
end