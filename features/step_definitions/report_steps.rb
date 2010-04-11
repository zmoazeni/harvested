When /^I run a project report for "([^\"]*)" for "([^\"]*)" and "([^\"]*)" the following entries should be returned:$/ do |project_name, start_date, end_date, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  project = Then %Q{there should be a project "#{project_name}"}
  entries = harvest_api.reports.by_project(project, start_date, end_date)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should_not be_nil
  end
end

When /^I run a project report for "([^\"]*)" for "([^\"]*)" and "([^\"]*)" the following entries should not be returned:$/ do |project_name, start_date, end_date, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  project = Then %Q{there should be a project "#{project_name}"}
  entries = harvest_api.reports.by_project(project, start_date, end_date)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should be_nil
  end
end

When /^I run a a project report for "([^\"]*)" for "([^\"]*)" and "([^\"]*)" filtered by my user the following entries should be returned:$/ do |project_name, start_date, end_date, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  project = Then %Q{there should be a project "#{project_name}"}
  user = Then %Q{there should be a user "#{@username}"}
  entries = harvest_api.reports.by_project(project, start_date, end_date, user)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should_not be_nil
  end
end

When /^I run a a project report for "([^\"]*)" for "([^\"]*)" and "([^\"]*)" filtered by my user the following entries should not be returned:$/ do |project_name, start_date, end_date, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  project = Then %Q{there should be a project "#{project_name}"}
  user = Then %Q{there should be a user "#{@username}"}
  entries = harvest_api.reports.by_project(project, start_date, end_date, user)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should be_nil
  end
end

When /^I run a people report for my user for "([^\"]*)" and "([^\"]*)" the following entries should be returned:$/ do |start_date, end_date, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  user = Then %Q{there should be a user "#{@username}"}
  entries = harvest_api.reports.by_user(user, start_date, end_date)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should_not be_nil
  end
end

When /^I run a people report for my user for "([^\"]*)" and "([^\"]*)" filtered by the project "([^\"]*)" the following entries should be returned:$/ do |start_date, end_date, project_name, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  user = Then %Q{there should be a user "#{@username}"}
  project = Then %Q{there should be a project "#{project_name}"}
  entries = harvest_api.reports.by_user(user, start_date, end_date, project)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should_not be_nil
  end
end

When /^I run a people report for my user for "([^\"]*)" and "([^\"]*)" filtered by the project "([^\"]*)" the following entries should not be returned:$/ do |start_date, end_date, project_name, table|
  start_date = Time.parse(start_date)
  end_date = Time.parse(end_date)
  user = Then %Q{there should be a user "#{@username}"}
  project = Then %Q{there should be a project "#{project_name}"}
  debugger
  entries = harvest_api.reports.by_user(user, start_date, end_date, project)
  table.raw.each do |row|
    entry = entries.detect {|e| e.notes == row.first }
    entry.should be_nil
  end
end