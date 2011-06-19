unless Time.respond_to?(:to_time)
  class Time
    def to_time; self; end
  end
end