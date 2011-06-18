module Harvest
  module API
    class Expenses < Base
      api_model Harvest::Expense
      
      include Harvest::Behavior::Crud
      
      def all(date = ::Time.now, user = nil)
        date = ::Time.parse(date) if String === date
        response = request(:get, credentials, "#{api_model.api_path}/#{date.yday}/#{date.year}", :query => of_user_query(user))
        api_model.parse(response.body)
      end
      
      # This is currently broken, but will come back to it
      def attach(expense, filename, receipt)
        body = ""
        body << "------------------------------b7edea381b46\r\n"
        body << %Q{Content-Disposition: form-data; name="expense[receipt]"; filename="#{filename}"\r\n}
        body << "Content-Type: image/png\r\n"
        body << "\r\n#{receipt.read}\r\n"
        body << "------------------------------b7edea381b46\r\n"
        
        request(:post, credentials, "#{api_model.api_path}/#{expense.to_i}/receipt", :headers => {'Content-Type' => 'multipart/form-data; boundary=------------------------------b7edea381b46'}, :body => body)
      end
    end
  end
end