When /^I create a client with the following:$/ do |table|
  response = harvest_api.clients.create(table.rows_hash)
end

Then /^there should be a client with the name "([^\"]*)"$/ do |name|
  clients = harvest_api.clients.all
  clients.detect {|c| c.name == name}.should_not be_nil
end

Then /^I should retrieve the client named "([^\"]*)" by id$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I update the client named "([^\"]*)" with the following description "([^\"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the description of "([^\"]*)" should be "([^\"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I delete the client named "([^\"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^there should not be a client with the name "([^\"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
