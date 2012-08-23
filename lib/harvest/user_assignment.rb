module Harvest
  class UserAssignment < Hashie::Mash
    include Harvest::Model

    delegate_methods :project_manager? => :is_project_manager

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
  end
end
