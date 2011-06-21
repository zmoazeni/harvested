# Shamelessly ripped from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/date/conversions.rb

unless ::Date.respond_to?(:to_time)
  class ::Date
    def to_time(*)
      ::Time.utc(year, month, day)
    end
  end
end