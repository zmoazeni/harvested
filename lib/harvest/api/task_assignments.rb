module Harvest
  module API
    class TaskAssignments < Base
      
      def all(project)
        response = request(:get, credentials, "/projects/#{project.to_i}/task_assignments")
        Harvest::TaskAssignment.parse(response.body)
      end
      
      def find(project, id)
        response = request(:get, credentials, "/projects/#{project.to_i}/task_assignments/#{id}")
        Harvest::TaskAssignment.parse(response.body, :single => true)
      end
      
      def create(task_assignment)
        response = request(:post, credentials, "/projects/#{task_assignment.project_id}/task_assignments", :body => task_assignment.task_xml)
        headers = response.headers["location"]
        headers = headers.first if headers.respond_to? :first
        id = headers.match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(task_assignment.project_id, id)
      end
      
      def update(task_assignment)
        request(:put, credentials, "/projects/#{task_assignment.project_id}/task_assignments/#{task_assignment.to_i}", :body => task_assignment.to_xml)
        find(task_assignment.project_id, task_assignment.id)
      end
      
      def delete(task_assignment)
        request(:delete, credentials, "/projects/#{task_assignment.project_id}/task_assignments/#{task_assignment.to_i}")
        task_assignment.id
      end
    end
  end
end
