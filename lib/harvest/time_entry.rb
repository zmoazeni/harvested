module Harvest
  class TimeEntry < Hashie::Dash
    include Harvest::Model
    
    property :id
    property :client
    property :hours
    property :notes
    
    property :project_id
    property :task_id
    property :project
    property :task
    property :spent_at
    property :created_at
    property :updated_at
    property :user_id
    property :of_user
    property :is_closed
    property :is_billed
    property :timer_started_at
    property :adjustment_record
    property :hours_without_timer
    
    skip_json_root true
    
    def initialize(args = {})
      args = args.stringify_keys
      self.spent_at = args.delete("spent_at") if args["spent_at"]
      super
    end
    
    def spent_at=(date)
      self["spent_at"] = (String === date ? Time.parse(date) : date)
    end
    
    def as_json(args = {})
      super(args).stringify_keys.tap do |hash| 
        hash.update("spent_at" => (spent_at.nil? ? nil : spent_at.to_time.xmlschema))
      end
    end
    
    alias_method :closed?, :is_closed
    alias_method :billed?, :is_billed
  end
end
