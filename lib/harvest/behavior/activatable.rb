module Harvest
  module Behavior
    
    # Activate/Deactivate behaviors that can be brought into API collections
    module Activatable
      # Deactivates the item. Does nothing if the item is already deactivated
      # 
      # @param [Harvest::BaseModel] model the model you want to deactivate
      # @return [Harvest::BaseModel] the deactivated model
      def deactivate(model)
        if model.active?
          request(:post, credentials, "#{api_model.api_path}/#{model.to_i}/toggle")
          model.is_active = false
        end
        model
      end
      
      # Activates the item. Does nothing if the item is already activated
      # 
      # @param [Harvest::BaseModel] model the model you want to activate
      # @return [Harvest::BaseModel] the activated model
      def activate(model)
        if !model.active?
          request(:post, credentials, "#{api_model.api_path}/#{model.to_i}/toggle")
          model.is_active = true
        end
        model
      end
    end
  end
end