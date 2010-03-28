require 'happymapper'
require 'httparty'
require 'base64'
require 'builder'
require 'delegate'

require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/base_api'
require 'harvest/clients'
require 'harvest/contacts'
require 'harvest/base_model'
require 'harvest/client'
require 'harvest/contact'
require 'harvest/robust_client'

class Harvest
  attr_reader :request, :credentials, :api_methods
  
  def initialize(subdomain, username, password, options = {})
    @api_methods = %w(clients contacts)
    
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