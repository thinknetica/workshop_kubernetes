# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe 'string concat' do
    let(:date) { Date.parse('2024-06-14') }

    it 'formats date' do
      expect(helper.format_date(date)).to eq('June 14, 2024')
    end
  end
end
