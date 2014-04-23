module Harvest
  class Credentials
    attr_accessor :subdomain, :username, :password

    def initialize(subdomain, username, password)
      @subdomain, @username, @password = subdomain, username, password
    end

    def valid?
      !subdomain.nil? && !username.nil? && !password.nil?
    end

    def basic_auth
      Base64.encode64("#{username}:#{password}").delete("\r\n")
    end

    def host
      "https://#{subdomain}.harvestapp.com"
    end
  end
end
