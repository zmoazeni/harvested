class Harvest
  class Clients
    def initialize(credentials)
      @credentials = credentials
    end
    
    def all
      response = Request.perform_http(:get, credentials, "/clients")
      Harvest::Models::Client.parse(response.body)
    end
    
    def create(params)
      builder = Builder::XmlMarkup.new
      xml = builder.client do |c|
        c.name(params["name"])
        
        if params["details"]
          c.details(params["details"])
        end
      end
      
      Request.perform_http(:post, credentials, "/clients", nil, xml)
    end
    
    private
      def credentials; @credentials; end
  end
end