When 'I create and assign a task "$1" to the project "$2"' do |task_name, project_name|
  project = Then %Q{there should be a project "#{project_name}"}
  p = harvest_api.projects.create_task(project, task_name)
  p.should == project
end

When 'I assign the task "$1" to the project "$2"' do |task_name, project_name|
  task = Then %Q{there should be a task "#{task_name}"}
  project = Then %Q{there should be a project "#{project_name}"}
  assignment = Harvest::TaskAssignment.new(:project => project, :task => task)
  harvest_api.task_assignments.create(assignment)
end

Then 'the task "$1" should be assigned to the project "$2"' do |task_name, project_name|
  task = Then %Q{there should be a task "#{task_name}"}
  project = Then %Q{there should be a project "#{project_name}"}
  assignments = harvest_api.task_assignments.all(project)
  assignment = assignments.detect {|a| a.project_id == project.to_i && a.task_id == task.to_i }
  assignment.should_not be_nil
  assignment
end

Then 'the task "$1" should not be assigned to the project "$2"' do |task_name, project_name|
  task = Then %Q{there should be a task "#{task_name}"}
  project = Then %Q{there should be a project "#{project_name}"}
  assignments = harvest_api.task_assignments.all(project)
  assignment = assignments.detect {|a| a.project_id == project.to_i && a.task_id == task.to_i }
  assignment.should be_nil
end

When 'I update the task "$1" for the project "$2" with the following:' do |task_name, project_name, table|
  assignment = Then %Q{the task "#{task_name}" should be assigned to the project "#{project_name}"}
  assignment.attributes = table.rows_hash
  harvest_api.task_assignments.update(assignment)
end

Then 'the task "$1" for the project "$2" should have the following attributes:' do |task_name, project_name, table|
  assignment = Then %Q{the task "#{task_name}" should be assigned to the project "#{project_name}"}
  table.rows_hash.each do |key, value|
    assignment.send(key).to_s.should == value
  end
end

When 'I remove the task "$1" from the project "$2"' do |task_name, project_name|
  assignment = Then %Q{the task "#{task_name}" should be assigned to the project "#{project_name}"}
  id = harvest_api.task_assignments.delete(assignment)
  id.should == assignment.id
end

When 'I try to remove the task "$1" from the project "$2"' do |task_name, project_name|
  assignment = Then %Q{the task "#{task_name}" should be assigned to the project "#{project_name}"}
  begin
    harvest_api.task_assignments.delete(assignment)
  rescue Harvest::HTTPError => e
    @error = e
  end
end