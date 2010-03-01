When /^I create a client with the following:$/ do |table|
  response = harvest_api.clients.create(table.rows_hash)
end

Then /^there should be a client with the name "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should_not be_nil
end

Then /^I should be able to retrieve the client named "([^\"]*)" by id$/ do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  harvest_api.clients.all(client.id).should == client
end

When /^I update the client named "([^\"]*)" with the following details "([^\"]*)"$/ do |name, details|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  harvest_api.clients.update(client.id, "details" => details)
end

Then /^the details of "([^\"]*)" should be "([^\"]*)"$/ do |name, details|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  client.details.should == details
end

When /^I delete the client named "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  harvest_api.clients.delete(client.id)
end

Then /^there should not be a client with the name "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should be_nil
end
