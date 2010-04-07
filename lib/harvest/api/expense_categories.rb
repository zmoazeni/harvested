module Harvest
  module API
    class ExpenseCategories < Base
      api_model Harvest::ExpenseCategory
      
      include Harvest::Behavior::Crud
    end
  end
end