#!/usr/bin/env ruby

# This is a hack a put together last night since I prefer Toggl for
# tracking time, but my company uses Harvest for reporting. I can
# add the requisite .... nm, I'll do this next week.
require 'csv'
require 'harvested'

#current_dir = File.dirname(__FILE__)
#toggl_file = current_dir + '/../Toggl_time_entries_2015-04-06_to_2015-04-12.csv'

toggl_file = ARGV[0]

subdomain = ENV['HARVEST_DOMAIN']
username = ENV['HARVEST_USERNAME']
password = ENV['HARVEST_PASSWORD']

harvest = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)

CsvEntry = Struct.new(
  :client,     # 2
  :project,    # 3
  :task,       # 4
  :description,# 5
  :date,       # 7
  :duration
)

def duration_to_sec(duration)
  hms = duration.split(':')
  in_secs =  hms[0].to_i * 3600 + hms[1].to_i * 60 + hms[1].to_i
end

def csv_to_entries(file)
  entries = Array.new

  CSV.foreach(file) do |row|
    duration_entry = row[-3]
    next unless duration_entry.match(/..:..:../)
    duration = duration_to_sec(duration_entry)
    next unless duration > 119
    c = CsvEntry.new()
    c.duration = duration
    c.client = row[2]
    c.project = row[3]
    c.task = row[4]
    c.description = row[5]
    c.date = row[7]
    entries << c
  end
  entries
end

def projects_from_harvest(harvest) # bad design
  projects = Hash.new()
  harvest.time.trackable_projects.each do |project|
    projects[project.name] = {
      id: project.id,
    }
    project.tasks.each do |task|
      projects[project.name][task.name] = task.id
    end
  end
  projects
end

entries = csv_to_entries(toggl_file)
projects = projects_from_harvest(harvest)

n=0
entries.each do |timer|
  time_entry = Harvest::TimeEntry.new(
    notes: timer.description,
    hours: timer.duration/3600.0,
    spent_at: timer.date,
    project_id: projects[timer.project][:id],
    task_id: projects[timer.project][timer.task])

  begin
    entered_time = harvest.time.create(time_entry)
    n+=1
    if (n % 5 == 0) then
        print n
    else
        print "."
    end
  rescue Harvest::BadRequest => e
      puts e.message
      puts e.backtrace.inspect
      puts "TASK info: project: #{timer.project}, task: #{timer.task}, notes: #{timer.description}"
  end
end
print "\n"
print "Submitted #{entries.length} time entries\n"
