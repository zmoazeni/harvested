module Harvest
  class Base
    attr_reader :request, :credentials

    # @see Harvest.client
    # @see Harvest.hardy_client
    def initialize(subdomain: nil, username: nil, password: nil, access_token: nil)
      @credentials = if subdomain && username && password
        BasicAuthCredentials.new(subdomain: subdomain, username: username, password: password)
      elsif access_token
        OAuthCredentials.new(access_token)
      else
        fail 'You must provide either :subdomain, :username, and :password or an oauth :access_token'
      end
    end

    # All API actions surrounding accounts
    #
    # == Examples
    #  harvest.account.rate_limit_status # Returns a Harvest::RateLimitStatus
    #
    # @return [Harvest::API::Account]
    def account
      @account ||= Harvest::API::Account.new(credentials)
    end

    # All API Actions surrounding Clients
    #
    # == Examples
    #  harvest.clients.all() # Returns all clients in the system
    #
    #  harvest.clients.find(100) # Returns the client with id = 100
    #
    #  client = Harvest::Client.new(:name => 'SuprCorp')
    #  saved_client = harvest.clients.create(client) # returns a saved version of Harvest::Client
    #
    #  client = harvest.clients.find(205)
    #  client.name = 'SuprCorp LTD.'
    #  updated_client = harvest.clients.update(client) # returns an updated version of Harvest::Client
    #
    #  client = harvest.clients.find(205)
    #  harvest.clients.delete(client) # returns 205
    #
    #  client = harvest.clients.find(301)
    #  deactivated_client = harvest.clients.deactivate(client) # returns an updated deactivated client
    #  activated_client = harvest.clients.activate(client) # returns an updated activated client
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
    #  harvest.contacts.all() # Returns all contacts in the system
    #  harvest.contacts.all(10) # Returns all contacts for the client id=10 in the system
    #
    #  harvest.contacts.find(100) # Returns the contact with id = 100
    #
    #  contact = Harvest::Contact.new(:first_name => 'Jane', :last_name => 'Doe', :client_id => 10)
    #  saved_contact = harvest.contacts.create(contact) # returns a saved version of Harvest::Contact
    #
    #  contact = harvest.contacts.find(205)
    #  contact.first_name = 'Jilly'
    #  updated_contact = harvest.contacts.update(contact) # returns an updated version of Harvest::Contact
    #
    #  contact = harvest.contacts.find(205)
    #  harvest.contacts.delete(contact) # returns 205
    #
    # @see Harvest::Behavior::Crud
    # @return [Harvest::API::Contacts]
    def contacts
      @contacts ||= Harvest::API::Contacts.new(credentials)
    end

    # All API Actions surrounding Projects
    #
    # == Examples
    #  harvest.projects.all() # Returns all projects in the system
    #
    #  harvest.projects.find(100) # Returns the project with id = 100
    #
    #  project = Harvest::Project.new(:name => 'SuprGlu' :client_id => 10)
    #  saved_project = harvest.projects.create(project) # returns a saved version of Harvest::Project
    #
    #  project = harvest.projects.find(205)
    #  project.name = 'SuprSticky'
    #  updated_project = harvest.projects.update(project) # returns an updated version of Harvest::Project
    #
    #  project = harvest.project.find(205)
    #  harvest.projects.delete(project) # returns 205
    #
    #  project = harvest.projects.find(301)
    #  deactivated_project = harvest.projects.deactivate(project) # returns an updated deactivated project
    #  activated_project = harvest.projects.activate(project) # returns an updated activated project
    #
    #  project = harvest.projects.find(401)
    #  harvest.projects.create_task(project, 'Bottling Glue') # creates and assigns a task to the project
    #
    # @see Harvest::Behavior::Crud
    # @see Harvest::Behavior::Activatable
    # @return [Harvest::API::Projects]
    def projects
      @projects ||= Harvest::API::Projects.new(credentials)
    end

    # All API Actions surrounding Tasks
    #
    # == Examples
    #  harvest.tasks.all() # Returns all tasks in the system
    #
    #  harvest.tasks.find(100) # Returns the task with id = 100
    #
    #  task = Harvest::Task.new(:name => 'Server Administration' :default => true)
    #  saved_task = harvest.tasks.create(task) # returns a saved version of Harvest::Task
    #
    #  task = harvest.tasks.find(205)
    #  task.name = 'Server Administration'
    #  updated_task = harvest.tasks.update(task) # returns an updated version of Harvest::Task
    #
    #  task = harvest.task.find(205)
    #  harvest.tasks.delete(task) # returns 205
    #
    # @see Harvest::Behavior::Crud
    # @return [Harvest::API::Tasks]
    def tasks
      @tasks ||= Harvest::API::Tasks.new(credentials)
    end

    # All API Actions surrounding Users
    #
    # == Examples
    #  harvest.users.all() # Returns all users in the system
    #
    #  harvest.users.find(100) # Returns the user with id = 100
    #
    #  user = Harvest::User.new(:first_name => 'Edgar', :last_name => 'Ruth', :email => 'edgar@ruth.com', :password => 'mypassword', :timezone => :cst, :admin => false, :telephone => '444-4444')
    #  saved_user = harvest.users.create(user) # returns a saved version of Harvest::User
    #
    #  user = harvest.users.find(205)
    #  user.email = 'edgar@ruth.com'
    #  updated_user = harvest.users.update(user) # returns an updated version of Harvest::User
    #
    #  user = harvest.users.find(205)
    #  harvest.users.delete(user) # returns 205
    #
    #  user = harvest.users.find(301)
    #  deactivated_user = harvest.users.deactivate(user) # returns an updated deactivated user
    #  activated_user = harvest.users.activate(user) # returns an updated activated user
    #
    #  user = harvest.users.find(401)
    #  harvest.users.reset_password(user) # will trigger the reset password feature of harvest and shoot the user an email
    #
    # @see Harvest::Behavior::Crud
    # @see Harvest::Behavior::Activatable
    # @return [Harvest::API::Users]
    def users
      @users ||= Harvest::API::Users.new(credentials)
    end

    # All API Actions surrounding assigning tasks to projects
    #
    # == Examples
    #  project = harvest.projects.find(101)
    #  harvest.task_assignments.all(project) # returns all tasks assigned to the project  (as Harvest::TaskAssignment)
    #
    #  project = harvest.projects.find(201)
    #  harvest.task_assignments.find(project, 5) # returns the task assignment with ID 5 that is assigned to the project
    #
    #  project = harvest.projects.find(301)
    #  task = harvest.tasks.find(100)
    #  assignment = Harvest::TaskAssignment.new(:task_id => task.id, :project_id => project.id)
    #  saved_assignment = harvest.task_assignments.create(assignment) # returns a saved version of the task assignment
    #
    #  project = harvest.projects.find(401)
    #  assignment = harvest.task_assignments.find(project, 15)
    #  assignment.hourly_rate = 150
    #  updated_assignment = harvest.task_assignments.update(assignment) # returns an updated assignment
    #
    #  project = harvest.projects.find(501)
    #  assignment = harvest.task_assignments.find(project, 25)
    #  harvest.task_assignments.delete(assignment) # returns 25
    #
    # @return [Harvest::API::TaskAssignments]
    def task_assignments
      @task_assignments ||= Harvest::API::TaskAssignments.new(credentials)
    end

    # All API Actions surrounding assigning users to projects
    #
    # == Examples
    #  project = harvest.projects.find(101)
    #  harvest.user_assignments.all(project) # returns all users assigned to the project  (as Harvest::UserAssignment)
    #
    #  project = harvest.projects.find(201)
    #  harvest.user_assignments.find(project, 5) # returns the user assignment with ID 5 that is assigned to the project
    #
    #  project = harvest.projects.find(301)
    #  user = harvest.users.find(100)
    #  assignment = Harvest::UserAssignment.new(:user_id => user.id, :project_id => project.id)
    #  saved_assignment = harvest.user_assignments.create(assignment) # returns a saved version of the user assignment
    #
    #  project = harvest.projects.find(401)
    #  assignment = harvest.user_assignments.find(project, 15)
    #  assignment.project_manager = true
    #  updated_assignment = harvest.user_assignments.update(assignment) # returns an updated assignment
    #
    #  project = harvest.projects.find(501)
    #  assignment = harvest.user_assignments.find(project, 25)
    #  harvest.user_assignments.delete(assignment) # returns 25
    #
    # @return [Harvest::API::UserAssignments]
    def user_assignments
      @user_assignments ||= Harvest::API::UserAssignments.new(credentials)
    end

    # All API Actions surrounding managing expense categories
    #
    # == Examples
    #  harvest.expense_categories.all() # Returns all expense categories in the system
    #
    #  harvest.expense_categories.find(100) # Returns the expense category with id = 100
    #
    #  category = Harvest::ExpenseCategory.new(:name => 'Mileage', :unit_price => 0.485)
    #  saved_category = harvest.expense_categories.create(category) # returns a saved version of Harvest::ExpenseCategory
    #
    #  category = harvest.clients.find(205)
    #  category.name = 'Travel'
    #  updated_category = harvest.expense_categories.update(category) # returns an updated version of Harvest::ExpenseCategory
    #
    #  category = harvest.expense_categories.find(205)
    #  harvest.expense_categories.delete(category) # returns 205
    #
    # @see Harvest::Behavior::Crud
    # @return [Harvest::API::ExpenseCategories]
    def expense_categories
      @expense_categories ||= Harvest::API::ExpenseCategories.new(credentials)
    end

    # All API Actions surrounding expenses
    #
    # == Examples
    #  harvest.expenses.all() # Returns all expenses for the current week
    #  harvest.expenses.all(Time.parse('11/12/2009')) # returns all expenses for the week of 11/12/2009
    #
    #  harvest.expenses.find(100) # Returns the expense with id = 100
    def expenses
      @expenses ||= Harvest::API::Expenses.new(credentials)
    end

    def time
      @time ||= Harvest::API::Time.new(credentials)
    end

    def reports
      @reports ||= Harvest::API::Reports.new(credentials)
    end

    def invoice_categories
      @invoice_categories ||= Harvest::API::InvoiceCategories.new(credentials)
    end

    def invoices
      @invoices ||= Harvest::API::Invoices.new(credentials)
    end

    # All API Actions surrounding invoice payments
    #
    # == Examples
    #  invoice = harvest.invoices.find(100)
    #  harvest.invoice_payments.all(invoice) # returns all payments for the invoice  (as Harvest::InvoicePayment)
    #
    #  invoice = harvest.invoices.find(100)
    #  harvest.invoice_payments.find(invoice, 5) # returns the payment with ID 5 that is assigned to the invoice
    #
    #  invoice = harvest.invoices.find(100)
    #  payment = Harvest::InvoicePayment.new(:invoice_id => invoice.id)
    #  saved_payment = harvest.invoice_payments.create(payment) # returns a saved version of the payment
    #
    #  invoice = harvest.invoices.find(100)
    #  payment = harvest.invoice_payments.find(invoice, 5)
    #  harvest.invoice_payments.delete(payment) # returns 5
    #
    # @return [Harvest::API::InvoicePayments]
    def invoice_payments
      @invoice_payments ||= Harvest::API::InvoicePayments.new(credentials)
    end

    # All API Actions surrounding invoice messages
    #
    # == Examples
    #
    #  invoice = harvest.invoices.find(100)
    #  harvest.invoice_messages.all(invoice) # returns all messages for the invoice (as Harvest::InvoicePayment)
    #
    #  invoice = harvest.invoices.find(100)
    #  harvest.invoice_messages.find(invoice, 5) # returns the message with ID 5, assigned to the invoice
    #
    #  invoice = harvest.invoices.find(100)
    #  message = Harvest::InvoiceMessage.new(:invoice_id => invoice.id)
    #  saved_message = harvest.invoice_messages.create(message) # returns a saved version of the message
    #
    #  invoice = harvest.invoices.find(100)
    #  message = harvest.invoice_messages.find(invoice, 5)
    #  harvest.invoice_messages.delete(message) # returns 5
    #
    #  invoice = harvest.invoices.find(100)
    #  message = Harvest::InvoiceMessage.new(:invoice_id => invoice.id)
    #  harvest.invoice_messages.mark_as_sent(message)
    #  
    #  invoice = harvest.invoices.find(100)
    #  message = Harvest::InvoiceMessage.new(:invoice_id => invoice.id)
    #  harvest.invoice_messages.mark_as_closed(message)
    #
    #  invoice = harvest.invoices.find(100)
    #  message = Harvest::InvoiceMessage.new(:invoice_id => invoice.id)
    #  harvest.invoice_messages.re_open(message)
    #
    # @return [Harvest::API::InvoiceMessages]
    def invoice_messages
      @invoice_messages ||= Harvest::API::InvoiceMessages.new(credentials)
    end
  end
end
