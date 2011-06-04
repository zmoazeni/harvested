require 'spec_helper'

describe 'harvest clients' do
  it 'allows adding, updating and removing clients' do
    cassette("client") do
      client      = harvest.clients.create(Harvest::Client.new(
        "name"    => "Joe's Steam Cleaning", 
        "details" => "Building API Widgets across the country")
      )
      client.name.should == "Joe's Steam Cleaning"
    
      client.name = "Joe and Frank's Steam Cleaning"
      client = harvest.clients.update(client)
      client.name.should == "Joe and Frank's Steam Cleaning"
    
      harvest.clients.delete(client)
      harvest.clients.all.size.should == 0
    end
  end
  
  it 'allows activating and deactivating clients' do
    cassette("client2") do
      client      = harvest.clients.create(Harvest::Client.new(
        "name"    => "Joe's Steam Cleaning",
        "details" => "Building API Widgets across the country"))
      client.should be_active
    
      client = harvest.clients.deactivate(client)
      client.should_not be_active
    
      client = harvest.clients.activate(client)
      client.should be_active
    end
  end
  
  context "contacts" do
    it "allows adding, updating, and removing contacts" do
      cassette("client3") do
        client      = harvest.clients.create(Harvest::Client.new(
          "name"    => "Joe's Steam Cleaning",
          "details" => "Building API Widgets across the country")
        )
        contact        = harvest.contacts.create(Harvest::Contact.new(
          "client_id"  => client.id, 
          "email"      => "jane@doe.com", 
          "first_name" => "Jane", 
          "last_name"  => "Doe")
        )
        contact.client_id.should == client.id
        contact.email.should == "jane@doe.com"
      
        harvest.contacts.delete(contact)
        harvest.contacts.all.size.should == 0
      end
    end
  end
end
