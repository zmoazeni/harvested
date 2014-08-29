require 'spec_helper'

describe Harvest::Project do
  it_behaves_like 'a json sanitizer', %w(hint_latest_record_at hint_earliest_record_at cache_version)
end
