module Harvest
  module API
    class Projects < Base
      api_methods crud + activatable
      api_model Harvest::Project
    
      include Harvest::Behavior::Crud
    
      def deactivate(project)
        if project.active?
          request(:put, credentials, "#{api_model.api_path}/#{project.to_i}/toggle", :headers => {'Content-Length' => '0'})
          project.active = false
        end
        project
      end
    
      def activate(project)
        if !project.active?
          request(:put, credentials, "#{api_model.api_path}/#{project.to_i}/toggle", :headers => {'Content-Length' => '0'})
          project.active = true
        end
        project
      end
    end
  end
end