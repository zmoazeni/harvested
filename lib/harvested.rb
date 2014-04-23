require 'httparty'
require 'base64'
require 'delegate'
require 'hashie'
require 'json'
require 'time'
require 'csv'

require 'ext/array'
require 'ext/hash'
require 'ext/date'
require 'ext/time'

require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/hardy_client'
require 'harvest/timezones'

require 'harvest/base'

%w(crud activatable).each {|a| require "harvest/behavior/#{a}"}
%w(model client contact project task user rate_limit_status task_assignment user_assignment expense_category expense time_entry invoice_category line_item invoice invoice_payment trackable_project).each {|a| require "harvest/#{a}"}
%w(base account clients contacts projects tasks users task_assignments user_assignments expense_categories expenses time reports invoice_categories invoices invoice_payments).each {|a| require "harvest/api/#{a}"}

module Harvest
  VERSION = File.read(File.expand_path(File.join(File.dirname(__FILE__), '..', 'VERSION'))).strip

  class << self

    # Creates a standard client that will raise all errors it encounters
    #
    # == Options
    # * Basic Authentication
    #   * +:subdomain+ - Your Harvest subdomain
    #   * +:username+ - Your Harvest username
    #   * +:password+ - Your Harvest password
    # * OAuth
    #   * +:access_token+ - An OAuth 2.0 access token
    # * +:ssl+ - Whether or not to use SSL when connecting to Harvest. This is dependent on whether your account supports it. Set to +true+ by default
    # == Examples
    #   Harvest.client(:access_token => "anaccestoken", :ssl => false)
    #
    #   Harvest.client(
    #     :subdomain => 'mysubdomain',
    #     :username => 'myusername',
    #     :password => 'mypassword',
    #   )
    #
    # @return [Harvest::Base]
    def client(*args)
      Harvest::Base.new(*args)
    end

    # Creates a hardy client that will retry common HTTP errors it encounters and sleep() if it determines it is over your rate limit
    #
    # == Options
    # * Basic Authentication
    #   * +:subdomain+ - Your Harvest subdomain
    #   * +:username+ - Your Harvest username
    #   * +:password+ - Your Harvest password
    # * OAuth
    #   * +:access_token+ - An OAuth 2.0 access token
    # * +:ssl+ - Whether or not to use SSL when connecting to Harvest. This is dependent on whether your account supports it. Set to +true+ by default
    # * +:retry+ - How many times the hardy client should retry errors. Set to +5+ by default.
    #
    # == Examples
    #   Harvest.hardy_client(:access_token => "anaccesstoken", :retry => 9)
    #
    #   Harvest.hardy_client(
    #     :subdomain => 'mysubdomain',
    #     :username => 'myusername',
    #     :password => 'mypassword',
    #     :ssl => true,
    #     :retry => 3
    #   )
    #
    # == Errors
    # The hardy client will retry the following errors
    # * Harvest::Unavailable
    # * Harvest::InformHarvest
    # * Net::HTTPError
    # * Net::HTTPFatalError
    # * Errno::ECONNRESET
    #
    # == Rate Limits
    # The hardy client will make as many requests as it can until it detects it has gone over the rate limit. Then it will +sleep()+ for the how ever long it takes for the limit to reset. You can find more information about the Rate Limiting at http://www.getharvest.com/api
    #
    # @return [Harvest::HardyClient] a Harvest::Base wrapped in a Harvest::HardyClient
    # @see Harvest::Base
    def hardy_client(*args)
      retries = args.last.respond_to?(:delete) && args.last.delete(:retry)
      Harvest::HardyClient.new(client(*args), retries || 5)
    end
  end
end
