module Harvest
  module API
    class Clients < Base
      api_model Harvest::Client
      
      include Harvest::Behavior::Crud
      include Harvest::Behavior::Activatable
    end
  end
end