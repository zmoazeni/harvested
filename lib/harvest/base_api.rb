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
      def request(method, credentials, path, options = {})
        response = HTTParty.send(method, "#{credentials.host}#{path}", :query => options[:query], :body => options[:body], :headers => {"Accept" => "application/xml", "Content-Type" => "application/xml; charset=utf-8", "Authorization" => "Basic #{credentials.basic_auth}"}.update(options[:headers] || {}))
        case response.code
        when 503
          raise Harvest::RateLimited.new(response)
        else
          response
        end
      end
  end
end