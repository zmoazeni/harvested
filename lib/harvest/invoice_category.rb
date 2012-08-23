module Harvest
  class InvoiceCategory < Hashie::Mash
    include Harvest::Model

    api_path '/invoice_item_categories'
    def self.json_root; "category"; end

  end
end
