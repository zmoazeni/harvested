Given 'I am using the credentials from "$1"' do |path|
  raise "You need a credentials file in support/harvest_credentials.yml!!" unless File.exist?("#{File.dirname(__FILE__)}/../#{path}")
  credentials = YAML.load_file("#{File.dirname(__FILE__)}/../#{path}")
  @username = credentials["username"]
  @password = credentials["password"]
  @subdomain = credentials["subdomain"]
  @ssl = credentials["ssl"]
end