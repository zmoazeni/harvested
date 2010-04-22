module Harvest
  module API
    class Users < Base
      api_model Harvest::User
    
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable
      
      # Triggers Harvest to reset the user's password and sends them an email to change it.
      # @overload reset_password(id)
      #   @param [Integer] id the id of the user you want to reset the password for
      # @overload reset_password(user)
      #   @param [Harvest::User] user the user you want to reset the password for
      # @return [Harvest::User] the user you passed in
      def reset_password(user)
        request(:post, credentials, "#{api_model.api_path}/#{user.to_i}/reset_password")
        user
      end
    end
  end
end