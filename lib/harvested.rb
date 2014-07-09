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

require 'harvest/version'
require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/hardy_client'
require 'harvest/timezones'

require 'harvest/base'

%w(crud activatable).each {|a| require "harvest/behavior/#{a}"}
%w(model client contact project task user rate_limit_status task_assignment user_assignment expense_category expense time_entry invoice_category line_item invoice invoice_payment invoice_message trackable_project).each {|a| require "harvest/#{a}"}
%w(base account clients contacts projects tasks users task_assignments user_assignments expense_categories expenses time reports invoice_categories invoices invoice_payments invoice_messages).each {|a| require "harvest/api/#{a}"}

module Harvest
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
    #
    # == Examples
    #   Harvest.client(subdomain: 'mysubdomain', username: 'myusername', password: 'mypassword')
    #   Harvest.client(access_token: 'myaccesstoken')
    #
    # @return [Harvest::Base]
    def client(subdomain: nil, username: nil, password: nil, access_token: nil)
      Harvest::Base.new(subdomain: subdomain, username: username, password: password, access_token: access_token)
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
    #
    # * +:retry+ - How many times the hardy client should retry errors. Set to +5+ by default.
    #
    # == Examples
    #   Harvest.hardy_client(subdomain: 'mysubdomain', username: 'myusername', password: 'mypassword', retry: 3)
    #
    #   Harvest.hardy_client(access_token: 'myaccesstoken', retries: 3)
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
    def hardy_client(subdomain: nil, username: nil, password: nil, access_token: nil, retries: 5)
      Harvest::HardyClient.new(client(subdomain: subdomain, username: username, password: password, access_token: access_token), retries)
    end
  end
end
