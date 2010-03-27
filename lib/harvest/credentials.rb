class Harvest
  class Credentials
    attr_accessor :subdomain, :username, :password, :ssl, :rate_limit_errors
    
    def initialize(subdomain, username, password, options = {})
      @subdomain, @username, @password = subdomain, username, password
      set_options(options)
    end
    
    def valid?
      !subdomain.nil? && !username.nil? && !password.nil?
    end
    
    def basic_auth
      Base64.encode64("#{username}:#{password}").delete("\r\n")
    end
    
    def host
      "#{ssl ? "https" : "http"}://#{subdomain}.harvestapp.com"
    end
    
    private
      def set_options(options)
        options.each do |k,v|
          instance_variable_set("@#{k}", v)
        end
        @ssl = true if @ssl.nil?
        @raise_rate_limit_errors = false if @rate_limit_errors.nil?
      end
  end
end