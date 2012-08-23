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
  class Task < Hashie::Mash
    include Harvest::Model

    api_path '/tasks'
    delegate_methods :default? => :is_default

    def active?
      !deactivated
    end
  end
end
