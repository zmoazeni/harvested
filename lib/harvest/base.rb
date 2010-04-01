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
  end
end