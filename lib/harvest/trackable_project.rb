module Harvest

  # The model for project-tasks combinations that can be added to the timesheet
  #
  # == Fields
  # [+id+] the id of the project
  # [+name+] the name of the project
  # [+client+] the name of the client of the project
  # [+client_id+] the client id of the project
  # [+tasks+] trackable tasks for the project
  class TrackableProject < Hashie::Mash
    include Harvest::Model
    
    skip_json_root true

    def initialize(args = {}, _ = nil)
      args       = args.to_hash.stringify_keys
      self.tasks = args.delete("tasks") if args["tasks"]
      super
    end
    
    def tasks=(tasks)
      self["tasks"] = Task.parse(tasks)
    end
  
    # The model for trackable tasks
    #
    # == Fields
    # [+id+] the id of the task
    # [+name+] the name of the task
    # [+billable+] whether the task is billable by default
    class Task < Hashie::Mash
      include Harvest::Model
      
      skip_json_root true
    end
  end
end