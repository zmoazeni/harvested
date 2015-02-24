require 'csv'

class String
  def strip_quotes
    gsub(/\A['"]+|['"]+\Z/, "")
  end
end

CsvEntry = Struct.new(
  :client,
  :project,
  :task,
  :description,
  :date,
  :duration
)

def duration_to_sec(duration)
  hms = duration.split(':')
  in_secs =  hms[0].to_i * 3600 + hms[1].to_i * 60 + hms[1].to_i
end



current_dir = File.dirname(__FILE__)

toggl_file = current_dir + '/../Toggl_time_entries_2015-02-16_to_2015-02-22.csv'
CSV.foreach(toggl_file) do |row|
  duration = row[-3]
  next unless duration.match(/..:..:../)
  p duration_to_sec(duration)
end
