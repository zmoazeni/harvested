class Harvest
  class BaseApi
    attr_reader :credentials
    
    def initialize(credentials)
      @credentials = credentials
    end
    
    protected
      def request(method, credentials, path, query = nil, body = nil)
        HTTParty.send(method, "#{credentials.host}#{path}", :query => query, :body => body, :headers => {"Accept" => "application/xml", "Content-Type" => "application/xml; charset=utf-8", "Authorization" => "Basic #{credentials.basic_auth}"})
      end
  end
end