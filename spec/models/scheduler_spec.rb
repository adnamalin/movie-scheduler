require_relative '../../app/models/scheduler'
require_relative '../../app/models/theater'
require 'spec_helper'

RSpec.describe Scheduler do

  let(:theater) {Theater.new({weekday_open: 11, weekday_close: 23})}
  let(:scheduler) {Scheduler.new(theater)}
  let(:movie) {Movie.new({title: "Serenity", run_time: 86, rating: "PG-13", release_year: "2005"})}
  let(:mock_start_time) {Time.new(Time.now.year, Time.now.month, Time.now.day, 15, 15)}

  describe 'scheuler instance variables' do

    it 'has preview time' do
      expect(scheduler.preview_time).to eq 15
    end

    it 'has clean up time' do
      expect(scheduler.clean_up_time).to eq 25
    end

  end

  describe 'scheduler finds total time for movies' do

    it 'takes a movie object adds preview and set up time' do
      expect(scheduler.total_movie_time_minutes(movie)).to eq 126
    end

    it 'converts run time minutes into seconds' do
      expect(scheduler.convert_to_secs(1)).to eq 60
    end

  end

  describe 'scheduler determines showing closest to close time for weekday' do

    it 'finds the first showings earliest start time' do
      expect(scheduler.find_first_showing_end_time(movie).hour).to eq 14
      expect(scheduler.find_first_showing_end_time(movie).min).to eq 36
    end

    it 'find the earliest start time for a showing' do
      expect(scheduler.find_first_showing_start_time(movie).hour).to eq 13
      expect(scheduler.find_first_showing_start_time(movie).min).to eq 10
    end

    it 'find the earliest start time for a showing' do
      expect(scheduler.schedule_weekday(movie)).to eq 13
    end

    it 'find next start time given previous start time' do
      expect(scheduler.find_next_start_time(mock_start_time, movie).hour).to eq 17
      expect(scheduler.find_next_start_time(mock_start_time, movie).min).to eq 20
    end

  end

end
