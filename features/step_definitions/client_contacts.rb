When /^I create a contact for the client named "([^\"]*)" with the following:$/ do |name, table|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  contact = harvest_api.contacts.create(table.rows_hash.merge("client_id" => client.id))
  contact.first_name.should == table.rows_hash["first_name"]
end

Then /^there should be a contact for the client named "([^\"]*)" with an email address "([^\"]*)"$/ do |name, email|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  
  contacts = harvest_api.contacts.all
  contact = contacts.detect {|c| c.email == email}
  contact.client_id.should == client.id
  
  contacts = harvest_api.contacts.all(client.id)
  contact2 = contacts.detect {|c| c.email == email}
  contact2.should == contact
end