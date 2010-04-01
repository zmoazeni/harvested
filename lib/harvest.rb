require 'happymapper'
require 'httparty'
require 'base64'
require 'builder'
require 'delegate'

require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/robust_client'
require 'harvest/timezones'

require 'harvest/crud'
require 'harvest/activatable'
require 'harvest/base'

require 'harvest/base_model'
%w(client contact project task person).each {|a| require "harvest/#{a}"}

require 'harvest/base_api'
%w(clients contacts projects tasks people).each {|a| require "harvest/#{a}"}

module Harvest
  class << self
    def client(subdomain, username, password, options = {})
      Harvest::Base.new(subdomain, username, password, options)
    end
    
    def robust_client(subdomain, username, password, options = {})
      Harvest::RobustClient.new(client(subdomain, username, password, options))
    end
  end
end