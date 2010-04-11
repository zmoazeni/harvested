module Harvest
  module API
    class UserAssignments < Base
      
      def all(project)
        response = request(:get, credentials, "/projects/#{project.to_i}/user_assignments")
        Harvest::UserAssignment.parse(response.body)
      end
      
      def find(project, id)
        response = request(:get, credentials, "/projects/#{project.to_i}/user_assignments/#{id}")
        Harvest::UserAssignment.parse(response.body, :single => true)
      end
      
      def create(user_assignment)
        response = request(:post, credentials, "/projects/#{user_assignment.project_id}/user_assignments", :body => user_assignment.user_xml)
        id = response.headers["location"].first.match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(user_assignment.project_id, id)
      end
      
      def update(user_assignment)
        request(:put, credentials, "/projects/#{user_assignment.project_id}/user_assignments/#{user_assignment.id}", :body => user_assignment.to_xml)
        find(user_assignment.project_id, user_assignment.id)
      end
      
      def delete(user_assignment)
        request(:delete, credentials, "/projects/#{user_assignment.project_id}/user_assignments/#{user_assignment.to_i}")
        user_assignment.id
      end
    end
  end
end