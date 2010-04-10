module Harvest
  module API
    class Expenses < Base
      api_model Harvest::Expense
      
      include Harvest::Behavior::Crud
      
      def all(date = Time.now)
        date = Time.parse(date) if String === date
        response = request(:get, credentials, "#{api_model.api_path}/#{date.yday}/#{date.year}")
        api_model.parse(response.body)
      end
    end
  end
end