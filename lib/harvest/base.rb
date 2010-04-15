module Harvest
  class Base
    attr_reader :request, :credentials
    
    # @see Harvest.client
    # @see Harvest.hardy_client
    def initialize(subdomain, username, password, options = {})
      options[:ssl] = true if options[:ssl].nil?
      @credentials = Credentials.new(subdomain, username, password, options[:ssl])
      raise InvalidCredentials unless credentials.valid?
    end
    
    # All API actions surrounding accounts
    #
    # == Examples
    #   harvest.account.rate_limit_status # Returns a Harvest::RateLimitStatus
    #
    # @return [Harvest::API::Account]
    def account
      @account ||= Harvest::API::Account.new(credentials)
    end
    
    # All API Actions surrounding Clients
    # 
    # == Examples
    #   harvest.clients.all() # Returns all clients in the system
    #   
    #   harvest.clients.find(100) # Returns the client with id = 100
    #   
    #   client = Harvest::Client.new(:name => 'SuprCorp')
    #   saved_client = harvest.clients.create(client) # returns a saved version of Harvest::Client
    #
    #   client = harvest.clients.find(205)
    #   client.name = 'SuprCorp LTD.'
    #   updated_client = harvest.clients.update(client) # returns an updated version of Harvest::Client
    #   
    #   client = harvest.clients.find(205)
    #   harvest.clients.delete(client) # returns 205
    #
    #   client = harvest.clients.find(301)
    #   deactivated_client = harvest.clients.deactivate(client) # returns an updated deactivated client
    #   activated_client = harvest.clients.activate(client) # returns an updated activated client
    # 
    # @see Harvest::Behavior::Crud
    # @see Harvest::Behavior::Activatable
    # @return [Harvest::API::Clients]
    def clients
      @clients ||= Harvest::API::Clients.new(credentials)
    end
    
    # All API Actions surrounding Client Contacts
    # 
    # == Examples
    #   harvest.contacts.all() # Returns all contacts in the system
    #   harvest.contacts.all(10) # Returns all contacts for the client id=10 in the system
    #   
    #   harvest.contacts.find(100) # Returns the contact with id = 100
    #   
    #   contact = Harvest::Contact.new(:first_name => 'Jane', :last_name => 'Doe', :client_id => 10)
    #   saved_contact = harvest.contacts.create(contact) # returns a saved version of Harvest::Contact
    #
    #   contact = harvest.contacts.find(205)
    #   contact.first_name = 'Jilly'
    #   updated_contact = harvest.contacts.update(contact) # returns an updated version of Harvest::Contact
    #   
    #   contact = harvest.contacts.find(205)
    #   harvest.contacts.delete(contact) # returns 205
    # 
    # @see Harvest::Behavior::Crud
    # @return [Harvest::API::Contacts]
    def contacts
      @contacts ||= Harvest::API::Contacts.new(credentials)
    end
    
    def projects
      @projects ||= Harvest::API::Projects.new(credentials)
    end
    
    def tasks
      @tasks ||= Harvest::API::Tasks.new(credentials)
    end
    
    def users
      @users ||= Harvest::API::Users.new(credentials)
    end
    
    def task_assignments
      @task_assignments ||= Harvest::API::TaskAssignments.new(credentials)
    end
    
    def user_assignments
      @user_assignments ||= Harvest::API::UserAssignments.new(credentials)
    end
    
    def expense_categories
      @expense_categories ||= Harvest::API::ExpenseCategories.new(credentials)
    end
    
    def expenses
      @expenses ||= Harvest::API::Expenses.new(credentials)
    end
    
    def time
      @time ||= Harvest::API::Time.new(credentials)
    end
    
    def reports
      @reports ||= Harvest::API::Reports.new(credentials)
    end
  end
end