module Harvest
  class Base
    attr_reader :request, :credentials
    
    def initialize(subdomain, username, password, options = {})
      options[:ssl] = true if options[:ssl].nil?
      @credentials = Credentials.new(subdomain, username, password, options[:ssl])
      raise InvalidCredentials unless credentials.valid?
    end
    
    def account
      @account ||= Harvest::API::Account.new(credentials)
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
    
    def task_assignments
      @task_assignments ||= Harvest::API::TaskAssignments.new(credentials)
    end
    
    def people_assignments
      @people_assignments ||= Harvest::API::PeopleAssignments.new(credentials)
    end
  end
end