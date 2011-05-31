module Harvest
  module Behavior
    module Crud
      # Retrieves all items
      # @return [Array<Harvest::BaseModel>] an array of models depending on where you're calling it from (e.g. [Harvest::Client] from Harvest::Base#clients)
      def all
        response = request(:get, credentials, api_model.api_path)
        api_model.parse(response.body)
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
      def find(id)
        response = request(:get, credentials, "#{api_model.api_path}/#{id}")
        api_model.parse(response.body, :single => true)
      end
      
      # Creates an item
      # @param [Harvest::BaseModel] model the item you want to create
      # @return [Harvest::BaseModel] the created model depending on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def create(model)
        response = request(:post, credentials, "#{api_model.api_path}", :body => model.to_xml)
        headers = response.headers["location"]
        headers = headers.first if headers.respond_to? :first
        id = headers.match(/\/.*\/(\d+)/)[1]
        find(id)
      end
      
      # Updates an item
      # @param [Harvest::BaseModel] model the model you want to update
      # @return [Harvest::BaseModel] the created model depending on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def update(model)
        request(:put, credentials, "#{api_model.api_path}/#{model.to_i}", :body => model.to_xml)
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
      def delete(model)
        request(:delete, credentials, "#{api_model.api_path}/#{model.to_i}")
        model.to_i
      end
    end
  end
end
