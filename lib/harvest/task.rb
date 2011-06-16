module Harvest

  # The model that contains information about a task
  #
  # == Fields
  # [+id+] (READONLY) the id of the task
  # [+name+] (REQUIRED) the name of the task
  # [+billable+] whether the task is billable by default
  # [+deactivated+] whether the task is deactivated
  # [+hourly_rate+] what the default hourly rate for the task is
  # [+default?+] whether to add this task to new projects by default
  class Task < Hashie::Dash
    include Harvest::Model

    api_path '/tasks'

    property :id
    property :name
    property :billable_by_default
    property :deactivated
    property :default_hourly_rate
    property :is_default
    property :created_at
    property :updated_at
    property :cache_version
    
    def active?
      !deactivated
    end

    alias_method :default?, :is_default
  end
end