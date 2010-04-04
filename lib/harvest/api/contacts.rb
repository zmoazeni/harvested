module Harvest
  module API
    class Contacts < Base
      api_model Harvest::Contact
    
      include Harvest::Behavior::Crud
    
      def all(client_id = nil)
        response = if client_id
          request(:get, credentials, "/clients/#{client_id}/contacts")
        else
          request(:get, credentials, "/contacts")
        end
      
        api_model.parse(response.body)
      end
    end
  end
end