require 'spec_helper'

describe Harvest::ExpenseCategory do
  it_behaves_like 'a json sanitizer', %w(cache_version)
end