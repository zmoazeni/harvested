module Harvest
  module API
    class TaskAssignments < Base
      api_methods crud
      
      def all(project)
        response = request(:get, credentials, "/projects/#{project.to_i}/task_assignments")
        Harvest::TaskAssignment.parse(response.body)
      end
      
      def find(project, id)
        response = request(:get, credentials, "/projects/#{project.to_i}/task_assignments/#{id}")
        Harvest::TaskAssignment.parse(response.body)
      end
      
      def create(task_assignment)
        response = request(:post, credentials, "/projects/#{task_assignment.project_id}/task_assignments", :body => task_assignment.task_xml)
        id = response.headers["location"].first.match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(task_assignment.project_id, id)
      end
    end
  end
end