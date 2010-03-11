class Harvest
  class Clients
    def initialize(credentials)
      @credentials = credentials
    end
    
    def all
      response = Request.perform(:get, credentials, "/clients")
      Harvest::Models::Client.parse(response.body)
    end
    
    def find(id)
      response = Request.perform(:get, credentials, "/clients/#{id}")
      Harvest::Models::Client.parse(response.body)
    end
    
    def create(params)
      builder = Builder::XmlMarkup.new
      xml = builder.client do |c|
        c.name(params["name"])
        c.details(params["details"]) if params["details"]
      end
      
      response = Request.perform(:post, credentials, "/clients", nil, xml)
      id = response.headers_hash["Location"].match(/\/clients\/(\d+)/)[1]
      find(id)
    end
    
    def update(id, params)
      builder = Builder::XmlMarkup.new
      xml = builder.client do |c|
        c.name(params["name"]) if params["name"]
        c.details(params["details"]) if params["details"]
      end
      
      Request.perform(:put, credentials, "/clients/#{id}", nil, xml)
      find(id)
    end
    
    def delete(id)
      Request.perform(:delete, credentials, "/clients/#{id}")
      id
    end
    
    def deactivate(id)
      client = find(id)
      if client.active?
        Request.perform(:post, credentials, "/clients/#{id}/toggle")
        client.active = false
      end
      client
    end
    
    def activate(id)
      client = find(id)
      if !client.active?
        Request.perform(:post, credentials, "/clients/#{id}/toggle")
        client.active = true
      end
      client
    end
    
    private
      def credentials; @credentials; end
  end
end