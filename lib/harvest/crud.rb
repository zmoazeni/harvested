module Harvest
  module Crud
    def all
      response = request(:get, credentials, api_model.api_path)
      api_model.parse(response.body)
    end
    
    def find(id)
      response = request(:get, credentials, "#{api_model.api_path}/#{id}")
      api_model.parse(response.body)
    end
    
    def create(model)
      response = request(:post, credentials, "#{api_model.api_path}", :body => model.to_xml)
      id = response.headers["location"].first.match(/\/.*\/(\d+)/)[1]
      find(model.id)
    end
    
    def update(model)
      request(:put, credentials, "#{api_model.api_path}/#{model.to_i}", :body => model.to_xml)
      find(model.id)
    end
    
    def delete(model)
      request(:delete, credentials, "#{api_model.api_path}/#{model.to_i}")
      model.id
    end
  end
end