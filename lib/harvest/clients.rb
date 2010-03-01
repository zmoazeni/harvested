class Harvest
  class Clients
    def initialize(credentials)
      @credentials = credentials
    end
    
    def all(id = nil)
      response = if id
        Request.perform_http(:get, credentials, "/clients/#{id}")
      else
        Request.perform_http(:get, credentials, "/clients")
      end
      
      Harvest::Models::Client.parse(response.body)
    end
    
    def create(params)
      builder = Builder::XmlMarkup.new
      xml = builder.client do |c|
        c.name(params["name"])
        c.details(params["details"]) if params["details"]
      end
      
      Request.perform_http(:post, credentials, "/clients", nil, xml)
    end
    
    def update(id, params)
      builder = Builder::XmlMarkup.new
      xml = builder.client do |c|
        c.name(params["name"]) if params["name"]
        c.details(params["details"]) if params["details"]
      end
      
      Request.perform_http(:put, credentials, "/clients/#{id}", nil, xml)
    end
    
    def delete(id)
      Request.perform_http(:delete, credentials, "/clients/#{id}")
    end
    
    private
      def credentials; @credentials; end
  end
end