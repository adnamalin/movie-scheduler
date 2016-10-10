require "rounding"

class Scheduler

  attr_reader :preview_time, :clean_up_time, :weekday_open, :weekday_close, :theater, :morning_prep_time

  def initialize(theater)
    @preview_time = 15
    @clean_up_time = 25
    @morning_prep_time = 15
    @theater = theater
  end

  def schedule_weekday(movie)
    collect = []
    first_showing_time = find_first_showing_start_time(movie)
    end_time = first_showing_time + movie_run_time_seconds(movie)
    collect << ["#{first_showing_time.hour}: #{first_showing_time.min}", "#{end_time.hour}: #{end_time.min}"]
    number_of_showings = number_of_showings(movie)

    start_time = first_showing_time
    number_of_showings.times do
      start_time = find_next_start_time(start_time, movie)
      end_time = start_time + movie_run_time_seconds(movie)
      collect << ["#{start_time.hour}: #{start_time.min}", "#{end_time.hour}: #{end_time.min}"]
    end
    p collect
  end

  def number_of_showings(movie)
    run_time = total_movie_time_minutes(movie)
    run_time_hour = total_movie_time_minutes(movie) / 60.to_f
    showings = 12/run_time_hour.to_f
    showings.floor - 1
  end

  def find_next_start_time(start_time, movie)
    next_start_time = start_time + total_movie_time_seconds(movie)
    rounding_diff = next_start_time.min - next_start_time.min.round_to(5)
    next_start_time - convert_to_secs(rounding_diff)
    # add set up time to last end time and round the next start time to nearest fifth
  end

  def find_next_end_time(start_time, movie)
    start_time + movie_run_time_seconds(movie)
  end

  def find_first_showing_start_time(movie)
    prelim_end_time = find_first_showing_end_time(movie)
    start_time = prelim_end_time - movie_run_time_seconds(movie)
    original_min = start_time.min
    until start_time.min % 5 == 0
      if original_min.min > 5
        start_time.min += 1
      else
        start_time.min -= 1
      end
    end
    start_time
  end

  def find_first_showing_end_time(movie)
    movie_time_seconds = total_movie_time_seconds(movie)
    earliest_start_time = calculate_earliest_start_time(movie_time_seconds)
    first_showing_end_time = theater.weekday_close
    while first_showing_end_time - movie_time_seconds > earliest_start_time
        first_showing_end_time -= movie_time_seconds
    end
    first_showing_end_time
  end

  def calculate_earliest_start_time(movie_run_time_in_secs)
    theater.weekday_open + convert_to_secs(morning_prep_time) + movie_run_time_in_secs
  end

  def total_movie_time_seconds(movie)
    convert_to_secs(total_movie_time_minutes(movie))
  end

  def total_movie_time_minutes(movie)
    movie.run_time + preview_time + clean_up_time
  end

  def movie_run_time_seconds(movie)
    convert_to_secs(movie.run_time)
  end

  def set_up_time
    convert_to_secs(preview_time) + convert_to_secs(clean_up_time)
  end

  def convert_to_secs(minutes)
    minutes*60
  end

  def preview_and_clean_time
    preview_time + clean_up_time
  end

end
