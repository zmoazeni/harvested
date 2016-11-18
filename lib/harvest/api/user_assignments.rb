module Harvest
  module API
    class UserAssignments < Base

      def all(project, query = {})
        response = request(:get, credentials, "/projects/#{project.to_i}/user_assignments", {query: query})
        Harvest::UserAssignment.parse(response.parsed_response)
      end
      
      def find(project, id)
        response = request(:get, credentials, "/projects/#{project.to_i}/user_assignments/#{id}")
        Harvest::UserAssignment.parse(response.parsed_response).first
      end
      
      def create(user_assignment)
        user_assignment = Harvest::UserAssignment.wrap(user_assignment)
        response = request(:post, credentials, "/projects/#{user_assignment.project_id}/user_assignments", :body => user_assignment.user_as_json.to_json)
        id = response.headers["location"].match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(user_assignment.project_id, id)
      end
      
      def update(user_assignment)
        user_assignment = Harvest::UserAssignment.wrap(user_assignment)
        request(:put, credentials, "/projects/#{user_assignment.project_id}/user_assignments/#{user_assignment.id}", :body => user_assignment.to_json)
        find(user_assignment.project_id, user_assignment.id)
      end
      
      def delete(user_assignment)
        request(:delete, credentials, "/projects/#{user_assignment.project_id}/user_assignments/#{user_assignment.to_i}")
        user_assignment.id
      end
    end
  end
end