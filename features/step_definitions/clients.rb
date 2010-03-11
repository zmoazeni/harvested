When /^I create a client with the following:$/ do |table|
  client = harvest_api.clients.create(table.rows_hash)
  client.name.should == table.rows_hash["name"]
end

Then /^there should be a client with the name "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should_not be_nil
end

Then /^I should be able to retrieve the client named "([^\"]*)" by id$/ do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  harvest_api.clients.find(client.id).should == client
end

When /^I update the client named "([^\"]*)" with the following details "([^\"]*)"$/ do |name, details|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  updated_client = harvest_api.clients.update(client.id, "details" => details)
  updated_client.name.should == name
end

Then /^the details of "([^\"]*)" should be "([^\"]*)"$/ do |name, details|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  client.details.should == details
end

When /^I delete the client named "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  id = harvest_api.clients.delete(client.id)
  id.should == client.id
end

Then /^there should not be a client with the name "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should be_nil
end

Then /^the client named "([^\"]*)" should be activated$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should be_active
end

Then /^the client named "([^\"]*)" should be deactivated$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should_not be_active
end

When /^I deactivate the client named "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  updated_client = harvest_api.clients.deactivate(client.id)
  updated_client.should_not be_active
end

When /^I activate the client named "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  updated_client = harvest_api.clients.activate(client.id)
  updated_client.should be_active
end