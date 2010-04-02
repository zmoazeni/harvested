module ErrorHelpers
  def set_time_and_return_and_error
    @time = Time.now
    @error = nil
    begin
      @clients = yield
    rescue => e
      @error = e
    end
  end
end

World(ErrorHelpers)