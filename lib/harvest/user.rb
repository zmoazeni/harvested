module Harvest
  
  # The model that contains information about a task
  #
  # == Fields
  # [+id+] (READONLY) the id of the user
  # [+email+] the email of the user
  # [+first_name+] the first name for the user
  # [+last_name+] the last name for the user
  # [+telephone+] the telephone for the user
  # [+password|password_confirmation+] the password for the user (only used on create.)
  # [+has_access_to_all_future_projects+] whether the user should be added to future projects by default
  # [+hourly_rate+] what the default hourly rate for the user is
  # [+admin?+] whether the user is an admin
  # [+contractor?+] whether the user is a contractor
  # [+contractor?+] whether the user is a contractor
  # [+timezone+] the timezone for the user.
  class User < BaseModel
    include HappyMapper
    
    api_path '/people'
    element :id, Integer
    element :email, String
    element :first_name, String, :tag => 'first-name'
    element :last_name, String, :tag => 'last-name'
    element :has_access_to_all_future_projects, Boolean, :tag => 'has-access-to-all-future-projects'
    element :hourly_rate, Float, :tag => 'default-hourly-rate'
    element :active, Boolean, :tag => 'is-active'
    element :admin, Boolean, :tag => 'is-admin'
    element :contractor, Boolean, :tag => 'is-contractor'
    element :telephone, String
    element :timezone, String
    element :password, String
    element :password_confirmation, String, :tag => 'password-confirmation'
    
    alias_method :active?, :active
    alias_method :admin?, :admin
    alias_method :contractor?, :contractor
    
    # Sets the timezone for the user. This can be done in a variety of ways.
    # 
    # == Examples
    #   user.timezone = :cst # the easiest way. CST, EST, MST, and PST are supported
    #   
    #   user.timezone = 'america/chicago' # a little more verbose
    #   
    #   user.timezone = 'Central Time (US & Canada)' # the most explicit way
    def timezone=(timezone)
      tz = timezone.to_s.downcase
      case tz
      when 'cst', 'cdt' then self.timezone = 'america/chicago'
      when 'est', 'edt' then self.timezone = 'america/new_york'
      when 'mst', 'mdt' then self.timezone = 'america/denver'
      when 'pst', 'pdt' then self.timezone = 'america/los_angeles'
      else
        if Harvest::Timezones::MAPPING[tz]
          @timezone = Harvest::Timezones::MAPPING[tz]
        else
          @timezone = timezone
        end
      end
    end
  end
end