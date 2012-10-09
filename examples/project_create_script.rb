# File: project_create_script.rb
# Date Created: 2012-10-08
# Author(s): Mark Rickert (mjar81@gmail.com) / Skookum Digital Works - http://skookum.com
#
# Description: This example script takes user input from the command line and
# creates a project based the selected options. It then assigns tasks from Harvest
# to the project based on an array. After the tasks are added, it addes all the
# currently active users to the project.

require "harvested"

subdomain = 'yoursubdomain'
username = 'yourusername'
password = 'yourpassword'

harvest = Harvest.hardy_client(subdomain, username, password)

puts "\nPlease search for a client by typing part of their name:"
cname = gets.chomp

# Filter out all the clients that don't match the typed string
client_search_results = harvest.clients.all.select { |c| c.name.downcase.include?(cname) }

case client_search_results.length
when 0
	puts "No client found.  Please try again.\n"
	abort
when 1
	# Result is exactly 1. We got the client.
	client_index = 0
when 1..15
	# Have the user select from a list of clients.
	puts "Please select from the following results:\n"
	client_search_results.each_with_index do |c, i|
		puts "  #{i+1}. #{c.name}"
	end

	client_index = gets.chomp.to_i - 1	
else
	puts "Too many client matches. Please try a more specific search term.\n"
	abort
end

client = client_search_results[client_index]

puts "\nClient found: #{client.name}\n"
puts "Please enter the project name:"
project_name = gets.chomp

puts "\nIs this project billable? (y/n)"
billable = gets.chomp.downcase == "y"

puts "\nAny project notes? (hit 'return' for none)"
notes = gets.chomp

puts "\nWhat sorts of tasks does this project need? Type \"p\" for project tasks or \"s\" for sales tasks.\n"
task_types = gets.chomp

# Determine what task list to use based on the project type.
if task_types.downcase == "p"
	# These are names of tasks that should already exist in Harvest
	use_tasks = ["Client Communication", "Planning", "Design", "Development", "Testing/QA", "Documentation", "Deployment"]
else
	use_tasks = ["Sales Calls", "Client Meetings", "Travel", "Estimating"]
end

# Filter the list of actual tasks we want to add to the project.
tasks = harvest.tasks.all.select { |t| use_tasks.include?(t.name) }

# Create the project
puts "Creating new project: \"#{project_name}\" for client: #{client.name}\n"
project = Harvest::Project.new(:name => project_name, :client_id => client.id, :billable => billable, :notes => notes)
project = harvest.projects.create(project)

# Add all the project tasks to the project
tasks.each do |t|
	puts "  Adding Task: #{t.name}"
	task_assignment = Harvest::TaskAssignment.new(:task_id => t.id, :project_id => project.id)
	task_assignment = harvest.task_assignments.create(task_assignment)
end

puts
# Add every active user to the project.
harvest.users.all.each do |u|
	next unless u.is_active?

	puts "  Adding User: #{u.first_name} #{u.last_name}"
	user_assignment = Harvest::UserAssignment.new(:user_id => u.id, :project_id => project.id)
	harvest.user_assignments.create(user_assignment)
end

puts "\nProject successfully created."
puts "You can find the project here: http://#{subdomain}.harvestapp.com/projects/#{project.id}/edit\n\n"
