module Harvest
  module Behavior
    module Crud
      # Retrieves all items
      # @return [Array<Harvest::BaseModel>] an array of models depending on where you're calling it from (e.g. [Harvest::Client] from Harvest::Base#clients)
      def all(user = nil, query_options = {})
        query = query_options.merge!(of_user_query(user))
        response = request(:get, credentials, api_model.api_path, :query => query)
        api_model.parse(response.parsed_response)
      end

      # Retrieves an item by id
      # @overload find(id)
      #   @param [Integer] the id of the item you want to retreive
      # @overload find(id)
      #   @param [String] id the String version of the id
      # @overload find(model)
      #   @param [Harvest::BaseModel] id you can pass a model and it will return a refreshed version
      #
      # @return [Harvest::BaseModel] the model depends on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def find(id, user = nil)
        raise "id required" unless id
        response = request(:get, credentials, "#{api_model.api_path}/#{id}", :query => of_user_query(user))
        api_model.parse(response.parsed_response).first
      end

      # Creates an item
      # @param [Harvest::BaseModel] model the item you want to create
      # @return [Harvest::BaseModel] the created model depending on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def create(model, user = nil)
        model = api_model.wrap(model)
        response = request(:post, credentials, "#{api_model.api_path}", :body => model.to_json, :query => of_user_query(user))
        id = response.headers["location"].match(/\/.*\/(\d+)/)[1]
        if user
          find(id, user)
        else
          find(id)
        end
      end

      # Updates an item
      # @param [Harvest::BaseModel] model the model you want to update
      # @return [Harvest::BaseModel] the created model depending on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def update(model, user = nil)
        model = api_model.wrap(model)
        request(:put, credentials, "#{api_model.api_path}/#{model.to_i}", :body => model.to_json, :query => of_user_query(user))
        find(model.id)
      end

      # Deletes an item
      # @overload delete(model)
      #  @param [Harvest::BaseModel] model the item you want to delete
      # @overload delete(id)
      #  @param [Integer] id the id of the item you want to delete
      # @overload delete(id)
      #  @param [String] id the String version of the id of the item you want to delete
      #
      # @return [Integer] the id of the item deleted
      def delete(model, user = nil)
        request(:delete, credentials, "#{api_model.api_path}/#{model.to_i}", :query => of_user_query(user))
        model.to_i
      end
    end
  end
end
