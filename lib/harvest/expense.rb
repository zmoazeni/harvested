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
    property :user_id
    property :spent_at
    property :created_at
    property :updated_at
    property :is_billed
    property :is_closed
    property :invoice_id
    property :has_receipt
    property :receipt_url

    def initialize(args = {})
      args          = args.stringify_keys
      self.spent_at = args.delete("spent_at") if args["spent_at"]
      super
    end

    def spent_at=(date)
      self["spent_at"] = (String === date ? Time.parse(date) : date)
    end

    def as_json(args = {})
      super(args).stringify_keys.tap do |hash|
        hash[json_root].update("spent_at" => (spent_at.nil? ? nil : spent_at.to_time.xmlschema))
        hash[json_root].delete("has_receipt")
        hash[json_root].delete("receipt_url")
      end
    end

    alias_method :billed?, :is_billed
    alias_method :closed?, :is_closed
    alias_method :has_receipt?, :has_receipt
  end
end
