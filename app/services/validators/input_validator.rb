module Validators
  class InputValidator
    def initialize(params)
      @time_interval = Tableless::TimeInterval.new
      @time_interval.from = params[:from]
      @time_interval.till = params[:till]
    end

    def execute
      @time_interval
    end
  end
end
