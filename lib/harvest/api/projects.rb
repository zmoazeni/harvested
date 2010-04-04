module Harvest
  module API
    class Projects < Base
      api_model Harvest::Project
      
      include Harvest::Behavior::Crud
      
      def create_task(project, task_name)
        response = request(:post, credentials, "/projects/#{project.to_i}/task_assignments/add_with_create_new_task", :body => task_xml(task_name))
        id = response.headers["location"].first.match(/\/.*\/(\d+)\/.*\/(\d+)/)[1]
        find(id)
      end
      
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
      
      private
        def task_xml(name)
          builder = Builder::XmlMarkup.new
          builder.task do |t|
            t.name(name)
          end
        end
    end
  end
end