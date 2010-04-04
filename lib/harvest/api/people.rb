module Harvest
  module API
    class People < Base
      api_model Harvest::Person
    
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable
    
      def reset_password(person)
        request(:post, credentials, "#{api_model.api_path}/#{person.to_i}/reset_password")
        person
      end
    end
  end
end