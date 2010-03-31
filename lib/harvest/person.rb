class Harvest
  class Person < BaseModel
    include HappyMapper
    
    tag "user"
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
  end
end