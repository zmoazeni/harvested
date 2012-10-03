module Harvest
  module API
    class Clients < Base
      api_model Harvest::Client
      
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable

      # Finds or Creates a Client by name
      # @overload find(name)
      #   @param [String] the name of the Client you want to retreive
      #
      # @return [Harvest::Client] the Client
      def find_or_create_by_name(name)
        unless client = self.all.detect {|c| c.name == name}
          client = self.create("name" => name)
        end
        client
      end
    end
  end
end