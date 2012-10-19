module Harvest
  module API
    class Invoices < Base
      api_model Harvest::Invoice
      include Harvest::Behavior::Crud
      
      def all(options = {})
        status = "status=#{options[:status]}" if options[:status]
        page = "page=#{options[:page]}" if options[:page]
        updated_since = "updated_since=#{options[:updated_since]}" if options[:updated_since]
        timeframe = "from=#{options[:timeframe][:from]}&to=#{options[:timeframe][:to]}" if options[:timeframe]
        params = [status,page,updated_since,timeframe].compact.join('&')
        params = "?#{params}" if params
        
        response = request(:get, credentials, "/invoices#{params}")

        api_model.parse(response.parsed_response)
      end
    end
  end
end