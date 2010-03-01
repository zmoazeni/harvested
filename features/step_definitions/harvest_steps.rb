Given /^I am using the credentials from "([^\"]*)"$/ do |path|
  credentials = YAML.load_file("#{File.dirname(__FILE__)}/../#{path}")
  @username = credentials["username"]
  @password = credentials["password"]
  @subdomain = credentials["subdomain"]
  @ssl = credentials["ssl"]
end