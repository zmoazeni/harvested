require "happymapper"
require "httparty"
require "base64"
require "builder"

require "harvest/credentials"
require "harvest/response_validator"
require "harvest/errors"
require "harvest/base_api"
require "harvest/clients"
require "harvest/contacts"
require "harvest/base_model"
require "harvest/client"
require "harvest/contact"

class Harvest
  attr_reader :request, :credentials
  
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
end