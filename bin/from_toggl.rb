require 'csv'

class String
  def strip_quotes
    gsub(/\A['"]+|['"]+\Z/, "")
  end
end

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

current_dir = File.dirname(__FILE__)
entries = Array.new

toggl_file = current_dir + '/../Toggl_time_entries_2015-02-16_to_2015-02-22.csv'
CSV.foreach(toggl_file) do |row|
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

p entries[-1]
