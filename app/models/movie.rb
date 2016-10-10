class Movie

  attr_reader :title, :run_time, :release_year, :rating

  def initialize(args)
    @title = args.fetch(:title, "No Title Provided")
    @run_time = args.fetch(:run_time, nil)
    @rating = args.fetch(:rating, "No Rating Provided")
    @release_year = args.fetch(:release_year, "No Release Year Provided")
  end

end
