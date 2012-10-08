require 'spec_helper'

describe 'harvest clients' do
  it 'allows adding, updating and removing clients' do
    client_attributes = FactoryGirl.attributes_for(:client)

    cassette("client") do
      client = harvest.clients.create(client_attributes)
      client.name.should == client_attributes[:name]

      client.name = "Joe and Frank's Steam Cleaning"
      client = harvest.clients.update(client)
      client.name.should == "Joe and Frank's Steam Cleaning"

      harvest.clients.delete(client)
      harvest.clients.all.select {|p| p.name == "Joe and Frank's Steam Cleaning"}.should == []
    end
  end

  it 'allows activating and deactivating clients' do
    cassette("client2") do
      client = harvest.clients.create(FactoryGirl.attributes_for(:client))
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
        client = harvest.clients.create(FactoryGirl.attributes_for(:client))

        contact        = harvest.contacts.create(
          "client_id"  => client.id,
          "email"      => "jane@example.com",
          "first_name" => "Jane",
          "last_name"  => "Doe"
        )
        contact.client_id.should == client.id
        contact.email.should == "jane@example.com"

        harvest.contacts.delete(contact)
        harvest.contacts.all.select {|e| e.email == "jane@example.com" }.should == []
      end
    end
  end
end
