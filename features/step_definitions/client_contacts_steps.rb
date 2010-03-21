When 'I create a contact for the client named "$1" with the following:' do |name, table|
  client = Then %Q{there should be a client with the name "#{name}"}
  contact = Harvest::Contact.new(table.rows_hash.merge("client_id" => client.id))
  harvest_api.contacts.create(contact)
end

Then 'there should be a contact "$1"' do |email|
  contacts = harvest_api.contacts.all
  contact = contacts.detect {|c| c.email == email}
  contact.should_not be_nil
  contact
end


Then 'there should not be a contact "$1"' do |email|
  contacts = harvest_api.contacts.all
  contact = contacts.detect {|c| c.email == email}
  contact.should be_nil
end

Then 'there should be a contact for the client named "$1" with an email address "$2"' do |name, email|
  client = Then %Q{there should be a client with the name "#{name}"}
  contact = Then %Q{there should be a contact "#{email}"}
  contact.client_id.should == client.id
  
  contacts = harvest_api.contacts.all(client.id)
  contact2 = contacts.detect {|c| c.email == email}
  contact2.should == contact
  contact
end

When 'I update the contact "$1" with the following:' do |email, table|
  contact = Then %Q{there should be a contact "#{email}"}
  contact.attributes = table.rows_hash
  harvest_api.contacts.update(contact)
end

Then 'the contact "$1" should have the following attributes:' do |email, table|
  contact = Then %Q{there should be a contact "#{email}"}
  table.rows_hash.each do |key, value|
    contact.send(key).should == value
  end
end

When 'I delete the contact "$1"' do |email|
  contact = Then %Q{there should be a contact "#{email}"}
  id = harvest_api.contacts.delete(contact)
  id.should == contact.id
end