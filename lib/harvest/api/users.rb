module Harvest
  module API
    class Users < Base
      api_model Harvest::User
    
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable
    
      def reset_password(user)
        request(:post, credentials, "#{api_model.api_path}/#{user.to_i}/reset_password")
        user
      end
    end
  end
end