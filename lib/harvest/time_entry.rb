module Harvest
  class TimeEntry < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    delegate_methods(:closed? => :is_closed,
                     :billed? => :is_billed)

    def initialize(args = {})
      args = args.stringify_keys
      self.spent_at = args.delete("spent_at") if args["spent_at"]
      super
    end

    def spent_at=(date)
      self["spent_at"] = (String === date ? Time.parse(date) : date)
    end

    def as_json(args = {})
      super(args).stringify_keys.tap do |hash|
        hash.update("spent_at" => (spent_at.nil? ? nil : spent_at.to_time.xmlschema))
      end
    end
  end
end
