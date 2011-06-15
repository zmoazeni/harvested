module Harvest
  class TimeEntry < Hashie::Dash
    include Harvest::Model
    
    property :id
    property :client
    property :project
    property :task
    property :hours
    property :notes
    
    property :project_id
    property :task_id
    property :spent_at
    property :created_at
    property :updated_at
    property :user_id
    property :of_user
    property :closed
    property :billed
    property :of_user
    
    def spent_at=(date)
      @spent_at = (String === date ? Time.parse(date) : date)
    end
    
    def to_xml
      builder = Builder::XmlMarkup.new
      builder.request do |r|
        r.tag!('notes', notes) if notes
        r.tag!('hours', hours) if hours
        r.tag!('project_id', project_id) if project_id
        r.tag!('task_id', task_id) if task_id
        r.tag!('spent_at', spent_at) if spent_at
        r.tag!('of_user', of_user) if of_user
      end
    end
    
    alias_method :closed?, :closed
    alias_method :billed?, :billed
  end
end