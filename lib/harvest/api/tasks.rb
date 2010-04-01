module Harvest
  module API
    class Tasks < Base
      api_methods crud
      api_model Harvest::Task
    
      include Harvest::Behavior::Crud
    end
  end
end