module Harvest
  class TimeEntry < Hashie::Mash
    include Harvest::Model

    skip_json_root true
    delegate_methods(:closed? => :is_closed,
                     :billed? => :is_billed)

    def initialize(args = {}, _ = nil)
      args = args.to_hash.stringify_keys
      super
    end

  end
end
