module Harvest
  module API
    class PeopleAssignments < Base
      
      def all(project)
        response = request(:get, credentials, "/projects/#{project.to_i}/user_assignments")
        Harvest::PersonAssignment.parse(response.body)
      end
      
      def find(project, id)
        response = request(:get, credentials, "/projects/#{project.to_i}/user_assignments/#{id}")
        Harvest::PersonAssignment.parse(response.body)
      end
      
      def create(person_assignment)
        response = request(:post, credentials, "/projects/#{person_assignment.project_id}/user_assignments", :body => person_assignment.person_xml)
        id = response.headers["location"].first.match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(person_assignment.project_id, id)
      end
      
      def update(person_assignment)
        request(:put, credentials, "/projects/#{person_assignment.project_id}/user_assignments/#{person_assignment.id}", :body => person_assignment.to_xml)
        find(person_assignment.project_id, person_assignment.id)
      end
      
      # def delete(person_assignment)
      #   request(:delete, credentials, "/projects/#{person_assignment.project_id}/person_assignments/#{person_assignment.to_i}")
      #   person_assignment.id
      # end
    end
  end
end