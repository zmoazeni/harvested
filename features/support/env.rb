$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'harvested'
require 'ruby-debug'
require 'fakeweb'

require 'rspec/expectations'

Before do
  FakeWeb.clean_registry
  FakeWeb.allow_net_connect = true
end

Before('@disconnected') do
  FakeWeb.allow_net_connect = false
end

Before('@clean') do
  credentials = YAML.load_file("#{File.dirname(__FILE__)}/harvest_credentials.yml")
  api = Harvest.hardy_client(credentials["subdomain"], credentials["username"], credentials["password"], :ssl => credentials["ssl"])
  
  api.users.all.each do |u|
    api.users.delete(u) if u.email != credentials["username"]
  end
  my_user = api.users.all.first
  
  api.reports.time_by_user(my_user, Time.parse('01/01/2000'), Time.now).each do |time|
    api.time.delete(time)
  end
  
  api.reports.expenses_by_user(my_user, Time.parse('01/01/2000'), Time.now).each do |time|
    api.expenses.delete(time)
  end
  
  %w(expenses expense_categories projects contacts clients tasks).each do |collection|
    api.send(collection).all.each {|m| api.send(collection).delete(m) }
  end
end
