require "happymapper"
require "typhoeus"
require "base64"
require "builder"

require "harvest/credentials"
require "harvest/errors"
require "harvest/request"
require "harvest/base_api"
require "harvest/clients"
require "harvest/contacts"
require "harvest/base_model"
require "harvest/client"
require "harvest/contact"

class Harvest
  def initialize(subdomain, username, password, options = {})
    options[:ssl] = true if options[:ssl].nil?
    @credentials = Credentials.new(subdomain, username, password, options[:ssl])
    raise InvalidCredentials unless credentials.valid?
  end
  
  def clients
    @clients ||= Harvest::Clients.new(credentials)
  end
  
  def contacts
    @contacts ||= Harvest::Contacts.new(credentials)
  end
  
  private
    def credentials; @credentials; end
end