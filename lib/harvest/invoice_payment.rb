module Harvest
  class InvoicePayment < Hashie::Mash
    include Harvest::Model

    api_path '/payments'
    def self.json_root; 'payment'; end
  end
end
