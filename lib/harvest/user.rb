module Harvest
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