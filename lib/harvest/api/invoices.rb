module Harvest
  module API
    class Invoices < Base
      api_model Harvest::Invoice
      include Harvest::Behavior::Crud
      
      def create(*)
        raise "Creating and updating invoices are not implemented due to API issues"
      end
      
      def update(*)
        raise "Creating and updating invoices are not implemented due to API issues"
      end
    end
  end
end