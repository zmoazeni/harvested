module Harvest
  class BasicAuthCredentials
    def initialize(subdomain: nil, username: nil, password: nil)
      @subdomain, @username, @password = subdomain, username, password
    end

    def set_authentication(request_options)
      request_options[:headers] ||= {}
      request_options[:headers]["Authorization"] = "Basic #{basic_auth}"
    end

    def host
      "https://#{@subdomain}.harvestapp.com"
    end

    private

    def basic_auth
      Base64.encode64("#{@username}:#{@password}").delete("\r\n")
    end
  end

  class OAuthCredentials
    def initialize(access_token)
      @access_token = access_token
    end

    def set_authentication(request_options)
      request_options[:query] ||= {}
      request_options[:query]["access_token"] = @access_token
    end

    def host
      "https://api.harvestapp.com"
    end
  end
end
