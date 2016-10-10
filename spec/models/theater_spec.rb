require_relative '../../app/models/theater'
require 'spec_helper'

RSpec.describe Theater do

  let(:theater) {Theater.new({weekday_open: 11, weekday_close: 23})}

  describe 'theater instance variables' do

    it 'has 11:00 as open time for weekday' do
      expect(theater.weekday_open.hour).to eq 11
    end

    it 'has 23:00 as close time for weekday' do
      expect(theater.weekday_close.hour).to eq 23
    end

  end

end
