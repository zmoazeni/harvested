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
    property :day_entries
    
    skip_json_root true
    
    def initialize(args = {})
      args = args.with_indifferent_access
      self.spent_at = args.delete(:spent_at) if args[:spent_at]
      super
    end
    
    def spent_at=(date)
      self[:spent_at] = (String === date ? Time.parse(date) : date)
    end
    
    def as_json(args = {})
      super(args).with_indifferent_access.tap do |hash| 
        hash.update("spent_at" => spent_at.try(:xmlschema))
      end
    end
    
    alias_method :closed?, :closed
    alias_method :billed?, :billed
  end
end