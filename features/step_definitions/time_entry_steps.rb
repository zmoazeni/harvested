When 'I create a time entry for the project "$1" and the task "$2" with the following:' do |project_name, task_name, table|
  task = Then %Q{there should be a task "#{task_name}"}
  project = Then %Q{there should be a project "#{project_name}"}
  entry = Harvest::TimeEntry.new(table.rows_hash.merge('project_id' => project.id, 'task_id' => task.id))
  created_entry = harvest_api.time.create(entry)
  created_entry.project.should == project.name
  created_entry.task.should == task.name
end

Then 'there should be a time entry "$1" on "$2"' do |notes, date|
  entries = harvest_api.time.all(date)
  entry = entries.detect {|e| e.notes == notes}
  entry.should_not be_nil
  entry
end

Then 'there should not be a time entry "$1" on "$2"' do |notes, date|
  entries = harvest_api.time.all(date)
  entry = entries.detect {|e| e.notes == notes}
  entry.should be_nil
end

When 'I update the time entry "$1" on "$2" with the following:' do |note, date, table|
  entry = Then %Q{there should be a time entry "#{note}" on "#{date}"}
  entry.attributes = table.rows_hash
  harvest_api.time.update(entry)
end

Then 'the time entry "$1" on "$2" should have the following attributes:' do |note, date, table|
  entry = Then %Q{there should be a time entry "#{note}" on "#{date}"}
  table.rows_hash.each do |key, value|
    entry.send(key).to_s.should == value
  end
end

When 'I delete the time entry "$1" on "$2"' do |note, date|
  entry = Then %Q{there should be a time entry "#{note}" on "#{date}"}
  id = harvest_api.time.delete(entry)
  entry.id.should == id
end