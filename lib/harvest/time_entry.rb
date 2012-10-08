module Harvest
  class TimeEntry < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    delegate_methods(:closed? => :is_closed,
                     :billed? => :is_billed)

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      self.spent_at = args.delete("spent_at") if args["spent_at"]
      super
    end

    def spent_at=(date)
      self["spent_at"] = Date.parse(date.to_s)
    end

    def as_json(args = {})
      super(args).to_hash.stringify_keys.tap do |hash|
        hash.update("spent_at" => (spent_at.nil? ? nil : spent_at.xmlschema))
      end
    end
  end
end
