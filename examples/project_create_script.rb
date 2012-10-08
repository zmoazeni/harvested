require "harvested"

subdomain = 'yoursubdomain'
username = 'yourusername'
password = 'yourpassword'

harvest = Harvest.hardy_client(subdomain, username, password)

puts
puts "Please search for a client by typing part of their name:"
cname = gets.chomp

#Filter out all the clients that don't match the typed string
client_search_results = harvest.clients.all.select { |c| c.name.downcase.include?(cname) }

case client_search_results.length
when 0
	puts "No client found.  Please try again."
	puts
	abort
when 1
	#Result is exactly 1. We got the client.
	client_index = 0
when 1..15
	#Have the user select from a list of clients.
	puts "Please select from the following results:"
	puts
	client_search_results.each_with_index do |c, i|
		puts "  #{i+1}. #{c.name}"
	end

	client_index = gets.chomp.to_i - 1	
else
	puts "Too many client matches. Please try a more specific search term."
	puts
	abort
end

client = client_search_results[client_index]

puts
puts "Client found: #{client.name}"
puts

puts "Please enter the project name:"
pname = gets.chomp
puts

puts "Is this project billable? (y/n)"
billable = gets.chomp.downcase == "y"
puts

puts "Any project notes? (hit 'return' for none)"
notes = gets.chomp
puts

#These are names of tasks that should already exist in Harvest
project_tasks = [];
project_tasks << "Client Communication"
project_tasks << "Planning"
project_tasks << "Design"
project_tasks << "Development"
project_tasks << "Testing/QA"
project_tasks << "Documentation"
project_tasks << "Deployment"

#These are names of tasks that should already exist in Harvest
sales_tasks = []
sales_tasks << "Sales Calls"
sales_tasks << "Client Meetings"
sales_tasks << "Travel"
sales_tasks << "Estimating"

puts "What sorts of tasks does this project need? Type \"p\" for project tasks or \"s\" for sales tasks."
task_types = gets.chomp
puts

#Determine what task list to use based on the project type.
if task_types.downcase == "p"
	use_tasks = project_tasks
else
	use_tasks = sales_tasks
end

#Filter the list of actual tasks we want to add to the project.
tasks = harvest.tasks.all.select { |t| use_tasks.include?(t.name) }

#Create the project
puts "Creating new project: \"#{pname}\" for client: #{client.name}"
puts
project = Harvest::Project.new(:name => pname, :client_id => client.id, :billable => billable, :notes => notes)
project = harvest.projects.create(project)

#Add all the project tasks to the project
tasks.each do |t|
	puts "  Adding Task: #{t.name}"
	task_assignment = Harvest::TaskAssignment.new(:task_id => t.id, :project_id => project.id)
	task_assignment = harvest.task_assignments.create(task_assignment)
end

puts
#Add every active user to the project.
harvest.users.all.each do |u|
	next unless u.is_active?

	puts "  Adding User: #{u.first_name} #{u.last_name}"
	user_assignment = Harvest::UserAssignment.new(:user_id => u.id, :project_id => project.id)
	harvest.user_assignments.create(user_assignment)
end

puts
puts "Project successfully created."
puts "You can find the project here: http://#{subdomain}.harvestapp.com/projects/#{project.id}/edit"
puts
puts

