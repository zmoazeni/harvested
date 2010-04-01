module Harvest
  module Behavior
    module Activatable
      def deactivate(model)
        if model.active?
          request(:post, credentials, "#{api_model.api_path}/#{model.to_i}/toggle")
          model.active = false
        end
        model
      end
    
      def activate(model)
        if !model.active?
          request(:post, credentials, "#{api_model.api_path}/#{model.to_i}/toggle")
          model.active = true
        end
        model
      end
    end
  end
end