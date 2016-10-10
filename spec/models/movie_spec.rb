require_relative '../../app/models/movie'
require 'spec_helper'

RSpec.describe Movie do

  let(:movie) {Movie.new({title: "Serenity", run_time: 86, rating: "PG-13", release_year: "2005"})}

  it 'has a title' do
    expect(movie.title).to eq "Serenity"
  end

  it 'has a run time' do
    expect(movie.run_time).to eq 86
  end

  it 'has a rating' do
    expect(movie.rating).to eq "PG-13"
  end

  it 'has a release year' do
    expect(movie.release_year).to eq "2005"
  end


end
