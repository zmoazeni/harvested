Then 'there should be a contact "$1" for the client "$2"' do |email, client_name|
  client = Then %Q{there should be a client "#{client_name}"}
  contact = Then %Q{there should be a contact "#{email}"}
  contact.client_id.should == client.id
  
  contacts = harvest_api.contacts.all(client.id)
  contact2 = contacts.detect {|c| c.email == email}
  contact2.should == contact
  
  contact
end