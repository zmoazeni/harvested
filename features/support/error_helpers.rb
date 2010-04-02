module ErrorHelpers
  def set_time_and_return_and_error
    @time = Time.now
    @error = nil
    begin
      @clients = yield
    rescue => e
      case e
      when Harvest::BadRequest, Harvest::NotFound, Harvest::RateLimited, Harvest::Unavailable, Harvest::InformHarvest, Net::HTTPError, Net::HTTPFatalError
        @error = e
      else
        raise e
      end
    end
  end
end

World(ErrorHelpers)