module Harvest
  class InvoiceCategory < Hashie::Mash
    include Harvest::Model

    api_path '/invoice_item_categories'
    def self.json_root; "invoice_item_category"; end

    class << self
      def parse(json)
        parsed = String === json ? JSON.parse(json) : json
        Array.wrap(parsed).map {|attrs| new(attrs["invoice_category"])}
      end
    end
  end
end
