module Harvest
  class TimeEntry < BaseModel
    include HappyMapper
    
    tag 'day_entry'
    
    element :id, Integer
    element :client, String
    element :project, String
    element :task, String
    element :hours, Float
    element :notes, String
    
    element :project_id, Integer
    element :task_id, Integer
    element :spent_at, Time
    element :created_at, Time
    element :updated_at, Time
    element :user_id, Integer
    element :of_user, Integer
    element :closed, Boolean, :tag => 'is-closed'
    element :billed, Boolean, :tag => 'is-billed'
    element :of_user, Integer
    
    def spent_at=(date)
      @spent_at = (String === date ? Time.strptime(date,'%m/%d/%Y') : date)
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
