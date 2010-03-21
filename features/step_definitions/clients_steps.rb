When 'I create a client with the following:' do |table|
  client = Harvest::Client.new(table.rows_hash)
  harvest_api.clients.create(client)
end

Then 'there should be a client with the name "$1"' do |name|
  clients = harvest_api.clients.all
  client = clients.detect {|c| c.name == name}
  client.should_not be_nil
  client
end

Then 'there should not be a client with the name "$1"' do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should be_nil
end

Then 'I should be able to retrieve the client named "$1" by id' do |name|
  client = Then %Q{there should be a client with the name "#{name}"}
  harvest_api.clients.find(client.id).should == client
end

When 'I update the client named "$1" with the following:' do |name, table|
  client = Then %Q{there should be a client with the name "#{name}"}
  client.attributes = table.rows_hash
  harvest_api.clients.update(client)
end

Then 'the client named "$1" should have the following attributes:' do |name, table|
  client = Then %Q{there should be a client with the name "#{name}"}
  table.rows_hash.each do |key, value|
    client.send(key).should == value
  end
end

When 'I delete the client named "$1"' do |name|
  client = Then %Q{there should be a client with the name "#{name}"}
  id = harvest_api.clients.delete(client)
  id.should == client.id
end

Then 'the client named "$1" should be activated' do |name|
  client = Then %Q{there should be a client with the name "#{name}"}
  client.should be_active
end

Then 'the client named "$1" should be deactivated' do |name|
  client = Then %Q{there should be a client with the name "#{name}"}
  client.should_not be_active
end

When 'I deactivate the client named "$1"' do |name|
  client = Then %Q{there should be a client with the name "#{name}"}
  harvest_api.clients.deactivate(client)
end

When 'I activate the client named "$1"' do |name|
  client = Then %Q{there should be a client with the name "#{name}"}
  harvest_api.clients.activate(client)
end