module Harvest
  class LineItem < Hashie::Dash
    property :kind
    property :description
    property :quantity
    property :unit_price
    property :amount
    property :taxed
    property :taxed2
    property :project_id
  end
end