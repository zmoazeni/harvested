require "happymapper"
require "typhoeus"
require "base64"
require "builder"

require "harvest/credentials"
require "harvest/errors"
require "harvest/request"
require "harvest/clients"
require "harvest/models/client"

class Harvest
  def initialize(subdomain, username, password, options = {})
    options[:ssl] = true if options[:ssl].nil?
    @credentials = Credentials.new(subdomain, username, password, options[:ssl])
    raise InvalidCredentials unless credentials.valid?
  end
  
  def clients
    @_harvest_clients ||= Harvest::Clients.new(credentials)
  end
  
  private
    def credentials; @credentials; end
end