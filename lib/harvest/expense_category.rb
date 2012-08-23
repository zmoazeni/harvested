module Harvest
  class ExpenseCategory < Hashie::Mash
    include Harvest::Model
    api_path '/expense_categories'

    def active?
      !deactivated
    end
  end
end
