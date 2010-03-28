class Harvest
  class BaseApi
    attr_reader :credentials
    
    def initialize(credentials)
      @credentials = credentials
    end
    
    
    class << self
      def api_methods(methods)
        class_eval <<-END
          def api_methods
            #{methods.inspect}
          end
        END
      end
    end
    
    protected
      def request(method, credentials, path, query = nil, body = nil)
        response = HTTParty.send(method, "#{credentials.host}#{path}", :query => query, :body => body, :headers => {"Accept" => "application/xml", "Content-Type" => "application/xml; charset=utf-8", "Authorization" => "Basic #{credentials.basic_auth}"})
        case response.code
        when 503
          raise Harvest::RateLimited.new(response)
        else
          response
        end
      end
  end
end