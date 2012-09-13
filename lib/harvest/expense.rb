module Harvest
  class Expense < Hashie::Mash
    include Harvest::Model

    api_path '/expenses'
    delegate_methods(:billed? => :is_billed,
                     :closed? => :is_closed)

    def initialize(args = {}, _ = nil)
      args          = args.to_hash.stringify_keys
      super
    end

    def as_json(args = {})
      super(args).to_hash.stringify_keys.tap do |hash|
        hash[json_root].delete("has_receipt")
        hash[json_root].delete("receipt_url")
      end
    end
  end
end
