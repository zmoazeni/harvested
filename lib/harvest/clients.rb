class Harvest
  class Clients < BaseApi
    api_methods crud + activatable
    
    def all
      response = request(:get, credentials, "/clients")
      Harvest::Client.parse(response.body)
    end
    
    def find(id)
      response = request(:get, credentials, "/clients/#{id}")
      Harvest::Client.parse(response.body)
    end
    
    def create(client)
      response = request(:post, credentials, "/clients", :body => client.to_xml)
      id = response.headers["location"].first.match(/\/clients\/(\d+)/)[1]
      find(client.id)
    end
    
    def update(client)
      request(:put, credentials, "/clients/#{client.id}", :body => client.to_xml)
      find(client.id)
    end
    
    def delete(client)
      request(:delete, credentials, "/clients/#{client.id}")
      client.id
    end
    
    def deactivate(client)
      if client.active?
        request(:post, credentials, "/clients/#{client.id}/toggle")
        client.active = false
      end
      client
    end
    
    def activate(client)
      if !client.active?
        request(:post, credentials, "/clients/#{client.id}/toggle")
        client.active = true
      end
      client
    end
  end
end