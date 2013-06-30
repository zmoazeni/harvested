module Harvest
  class Credentials
    LEGACY_ARGUMENTS = [:subdomain, :username, :password, :ssl]

    attr_accessor :adapter, :ssl

    def initialize(*args)
      options = if args.length.between?(3, 4)
        Hash[LEGACY_ARGUMENTS.zip(args)]
      elsif args.length == 1
        args.first
      else
        raise ArgumentError, "Invalid arguments passed"
      end

      @ssl = options.fetch(:ssl) { true }

      adapter_class = options[:access_token] ? OAuth2 : BasicAuth
      @adapter = adapter_class.new(options)
    end

    def host
      "#{ssl ? "https" : "http"}://#{domain}"
    end

    def method_missing(*args, &block)
      adapter.send(*args, &block)
    end

    def respond_to_missing?(*args)
      adapter.respond_to?(*args)
    end

    class OAuth2 < OpenStruct
      DOMAIN = "api.harvestapp.com"

      def valid?
        !access_token.nil?
      end

      def authenticate_request!(request)
        query = request.options[:query] ||= {}
        query[:access_token] = access_token
      end

      def domain
        DOMAIN
      end
    end

    class BasicAuth < OpenStruct
      def valid?
        !subdomain.nil? && !username.nil? && !password.nil?
      end

      def authenticate_request!(request)
        request.options[:basic_auth] = {
          :username => username,
          :password => password
        }
      end

      def domain
        "#{subdomain}.harvestapp.com"
      end
    end
  end
end
