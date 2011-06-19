module Harvest
  class UserAssignment < Hashie::Dash
    include Harvest::Model
    
    property :id
    property :user_id
    property :project_id
    property :deactivated
    property :is_project_manager
    property :hourly_rate
    property :created_at
    property :updated_at
    property :budget
    property :estimate
    
    def initialize(args = {})
      args = args.stringify_keys
      self.user    = args.delete("user") if args["user"]
      self.project = args.delete("project") if args["project"]
      super
    end
    
    def user=(user)
      self["user_id"] = user.to_i
    end
    
    def project=(project)
      self["project_id"] = project.to_i
    end
    
    def active?
      !deactivated
    end
    
    def user_as_json
      {"user" => {"id" => user_id}}
    end
    
    alias_method :project_manager?, :is_project_manager
  end
end