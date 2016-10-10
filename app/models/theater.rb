class Theater

  attr_reader :weekday_open_input_hour, :weekday_close_input_hour, :weekday_open, :weekday_close

  def initialize(args)
    @weekday_open_input_hour = args.fetch(:weekday_open, 11)
    @weekday_close_input_hour = args.fetch(:weekday_close, 23)
    @weekday_open = Time.new(Time.now.year, Time.now.month, Time.now.day, weekday_open_input_hour, 15)
    @weekday_close = Time.new(Time.now.year, Time.now.month, Time.now.day, weekday_close_input_hour, 00)
  end

end
