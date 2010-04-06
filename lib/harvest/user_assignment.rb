module Harvest
  class UserAssignment < BaseModel
    include HappyMapper
    
    tag 'user-assignment'
    element :id, Integer
    element :user_id, Integer, :tag => 'user-id'
    element :project_id, Integer, :tag => 'project-id'
    element :deactivated, Boolean
    element :project_manager, Boolean, :tag => 'is-project-manager'
    element :hourly_rate, Float, :tag => 'hourly-rate'
    
    def user=(user)
      @user_id = user.to_i
    end
    
    def project=(project)
      @project_id = project.to_i
    end
    
    def active?
      !deactivated
    end
    
    def user_xml
      builder = Builder::XmlMarkup.new
      builder.user do |t|
        t.id(user_id)
      end
    end
    
    alias_method :project_manager?, :project_manager
  end
end