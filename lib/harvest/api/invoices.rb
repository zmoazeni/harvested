module Harvest
  module API
    class Invoices < Base
      api_model Harvest::Invoice
      include Harvest::Behavior::Crud

      def all(options = {})
        query = {}
        query[:status]        = options[:status]        if options[:status]
        query[:page]          = options[:page]          if options[:page]
        query[:updated_since] = options[:updated_since] if options[:updated_since]
        if options[:timeframe]
          query[:from] = options[:timeframe][:from]
          query[:to]   = options[:timeframe][:to]
        end

        response = request(:get, credentials, "/invoices", :query => query)
        api_model.parse(response.parsed_response)
      end
    end
  end
end
