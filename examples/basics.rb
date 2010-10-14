require "harvested"

subdomain = 'yoursubdomain'
username = 'yourusername'
password = 'yourpassword'

harvest = Harvest.hardy_client(subdomain, username, password)

# Print out all users, clients, and projects on the account
puts "Users:"
harvest.users.all.each {|u| p u }

puts "Clients:"
harvest.clients.all.each {|c| p c }

puts "Projects:"
harvest.projects.all.each {|project| p project }

# Create a Client add a Project to that Client, Add a Task to the Project, track some Time against the Project/Task, and then Run a report against all time I've submitted

client = Harvest::Client.new(:name => 'SuprCorp')
client = harvest.clients.create(client)

project = Harvest::Project.new(:name => 'SuprGlu', :client_id => client.id, :notes => 'Some notes about this project')
project = harvest.projects.create(project)

harvest.projects.create_task(project, 'Bottling Glue')
task_assignment = harvest.task_assignments.all(project).first

time_entry = Harvest::TimeEntry.new(:notes => 'Bottled glue today', :hours => 8, :spent_at => "04/11/2010", :project_id => project.id, :task_id => task_assignment.task_id)
time_entry = harvest.time.create(time_entry)

entries = harvest.reports.time_by_project(project, Time.parse("04/11/2010"), Time.parse("04/12/2010"))
puts "Entries:"
entries.each {|e| p e}