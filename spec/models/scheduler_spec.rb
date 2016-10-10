require_relative '../../app/models/scheduler'
require 'spec_helper'

RSpec.describe Scheduler do

  let(:scheduler) {Scheduluer.new({title: "Serenity", run_time: 86, rating: "PG-13", release_year: "2005"})}

  describe 'weekday scheduler' do

    it 'takes a movie object adds preview and set up time' do
      expect(scheduler.total_movie_time).to_eq 121
    end

  end

end
