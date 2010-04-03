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
  assignment = assignments.first
  assignment.should_not be_nil
  assignment.project_id.should == project.to_i
  assignment.task_id.should == task.to_i
end