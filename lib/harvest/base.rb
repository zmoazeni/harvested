module Harvest
  class Base
    attr_reader :request, :credentials, :api_methods
  
    def initialize(subdomain, username, password, options = {})
      @api_methods = %w(clients contacts projects tasks people)
    
      options[:ssl] = true if options[:ssl].nil?
      @credentials = Credentials.new(subdomain, username, password, options[:ssl])
      raise InvalidCredentials unless credentials.valid?
    end
  
    def clients
      @clients ||= Harvest::API::Clients.new(credentials)
    end
  
    def contacts
      @contacts ||= Harvest::API::Contacts.new(credentials)
    end
  
    def projects
      @projects ||= Harvest::API::Projects.new(credentials)
    end
  
    def tasks
      @tasks ||= Harvest::API::Tasks.new(credentials)
    end
  
    def people
      @people ||= Harvest::API::People.new(credentials)
    end
  end
end