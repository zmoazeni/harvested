module Harvest
  class TaskAssignment < Hashie::Dash
    include Harvest::Model

    property :id
    property :task_id
    property :project_id
    property :billable
    property :deactivated
    property :hourly_rate
    property :budget
    property :estimate
    property :created_at
    property :updated_at
    
    def initialize(args = {})
      args = args.stringify_keys
      self.task    = args.delete("task") if args["task"]
      self.project = args.delete("project") if args["project"]
      super
    end
    
    def task=(task)
      self["task_id"] = task.to_i
    end

    def project=(project)
      self["project_id"] = project.to_i
    end

    def active?
      !deactivated
    end

    def task_as_json
      {"task" => {"id" => task_id}}
    end

    alias_method :billable?, :billable
  end
end