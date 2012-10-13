module Harvest
  module API
    class InvoiceCategories < Base
      api_model Harvest::InvoiceCategory
      include Harvest::Behavior::Crud

      def find(*)
        raise "find is unsupported for InvoiceCategories"
      end

      def create(model)
        model = api_model.wrap(model)
        response = request(:post, credentials, "#{api_model.api_path}", :body => model.to_json)
        id = response.headers["location"].match(/\/.*\/(\d+)/)[1]
        all.detect {|c| c.id == id.to_i }
      end

      def update(model, user = nil)
        model = api_model.wrap(model)
        request(:put, credentials, "#{api_model.api_path}/#{model.to_i}", :body => model.to_json, :query => of_user_query(user))
        all.detect {|c| c.id == model.id }
      end

    end
  end
end
