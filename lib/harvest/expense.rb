module Harvest
  class Expense < Hashie::Dash
    include Harvest::Model

    api_path '/expenses'

    property :id
    property :notes
    property :units
    property :total_cost
    property :project_id
    property :expense_category_id
    property :spent_at

    def spent_at=(date)
      @spent_at = (String === date ? Time.parse(date) : date)
    end
  end
end