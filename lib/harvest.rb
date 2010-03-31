require 'happymapper'
require 'httparty'
require 'base64'
require 'builder'
require 'delegate'

require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/robust_client'
require 'harvest/timezones'

require 'harvest/base_api'
%w(clients contacts projects tasks people).each {|a| require "harvest/#{a}"}

require 'harvest/base_model'
%w(client contact project task person).each {|a| require "harvest/#{a}"}


class Harvest
  attr_reader :request, :credentials, :api_methods
  
  def initialize(subdomain, username, password, options = {})
    @api_methods = %w(clients contacts projects tasks people)
    
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
  
  def projects
    @projects ||= Harvest::Projects.new(credentials)
  end
  
  def tasks
    @tasks ||= Harvest::Tasks.new(credentials)
  end
  
  def people
    @people ||= Harvest::People.new(credentials)
  end
  
  class << self
    def client(subdomain, username, password, options = {})
      new(subdomain, username, password, options)
    end
    
    def robust_client(subdomain, username, password, options = {})
      instance = new(subdomain, username, password, options)
      RobustClient.new(instance)
    end
  end
end