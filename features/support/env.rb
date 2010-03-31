$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'harvest'
require 'ruby-debug'
require 'artifice'

require 'spec/expectations'

After do
  Artifice.deactivate
end

Before('@clean') do
  credentials = YAML.load_file("#{File.dirname(__FILE__)}/harvest_credentials.yml")
  api = Harvest.robust_client(credentials["subdomain"], credentials["username"], credentials["password"], :ssl => credentials["ssl"])
  
  %w(contacts projects clients tasks people).each do |collection|
    api.send(collection).all.each {|m| api.send(collection).delete(m) }
  end
end