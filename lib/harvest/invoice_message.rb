module Harvest
  class InvoiceMessage < Hashie::Mash
    include Harvest::Model

    api_path '/messages'
    def self.json_root; 'message'; end
  end
end
