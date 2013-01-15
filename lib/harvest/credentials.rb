module Harvest
  class Credentials
    attr_accessor :subdomain, :username, :password, :ssl, :proxy
    
    def initialize(subdomain, username, password, ssl = true, proxy = nil)
      @subdomain, @username, @password, @ssl, @proxy = subdomain, username, password, ssl, proxy
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
  end
end
