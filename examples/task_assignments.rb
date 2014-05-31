require "harvested"

subdomain = 'yoursubdomain'
username = 'yourusername'
password = 'yourpassword'

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

# Create a Client add a Project to that Client

client = Harvest::Client.new(name: 'SuprCorp')
client = harvest.clients.create(client)

project = Harvest::Project.new(name: 'SuprGlu', client_id: client.id, notes: 'Some notes about this project')
project = harvest.projects.create(project)

# You can create an assign a task in one call
harvest.projects.create_task(project, 'Bottling Glue')
puts "Assigned the task 'Bottling Glue' to the project 'SuprGlu'"

# You can explicitly create the task and then assign it
task = Harvest::Task.new(name: 'Packaging Glue', hourly_rate: 30, billable: true)
task = harvest.tasks.create(task)

task_assignment = Harvest::TaskAssignment.new(task_id: task.id, project_id: project.id)
task_assignment = harvest.task_assignments.create(task_assignment)
puts "Assigned the task 'Packaging Glue' to the project 'SuprGlu'"
