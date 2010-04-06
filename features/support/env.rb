$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'harvest'
require 'ruby-debug'
require 'fakeweb'

require 'spec/expectations'

Before do
  FakeWeb.clean_registry
  FakeWeb.allow_net_connect = true
end

Before('@disconnected') do
  FakeWeb.allow_net_connect = false
end

Before('@clean') do
  credentials = YAML.load_file("#{File.dirname(__FILE__)}/harvest_credentials.yml")
  api = Harvest.robust_client(credentials["subdomain"], credentials["username"], credentials["password"], :ssl => credentials["ssl"])
  
  %w(contacts projects clients tasks).each do |collection|
    api.send(collection).all.each {|m| api.send(collection).delete(m) }
  end
  
  api.users.all.each do |p|
    begin
      api.users.delete(p)
    rescue Harvest::BadRequest
    end
  end
end
