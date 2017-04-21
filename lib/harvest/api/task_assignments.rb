module Harvest
  module API
    class TaskAssignments < Base
      
      def all(project, query = {})
        response = request(:get, credentials, "/projects/#{project.to_i}/task_assignments", {query: query})
        Harvest::TaskAssignment.parse(response.parsed_response)
      end
      
      def find(project, id)
        response = request(:get, credentials, "/projects/#{project.to_i}/task_assignments/#{id}")
        Harvest::TaskAssignment.parse(response.parsed_response).first
      end
      
      def create(task_assignment)
        task_assignment = Harvest::TaskAssignment.wrap(task_assignment)
        response = request(:post, credentials, "/projects/#{task_assignment.project_id}/task_assignments", :body => task_assignment.task_as_json.to_json)
        id = response.headers["location"].match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(task_assignment.project_id, id)
      end
      
      def update(task_assignment)
        task_assignment = Harvest::TaskAssignment.wrap(task_assignment)
        request(:put, credentials, "/projects/#{task_assignment.project_id}/task_assignments/#{task_assignment.to_i}", :body => task_assignment.to_json)
        find(task_assignment.project_id, task_assignment.id)
      end
      
      def delete(task_assignment)
        response = request(:delete, credentials, "/projects/#{task_assignment.project_id}/task_assignments/#{task_assignment.to_i}")
        task_assignment.id
      end
    end
  end
end
