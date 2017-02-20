# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { build(:event) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :event_date }
  end

  describe 'methods' do
    describe 'filter_by' do
      context 'returns collection without filtering' do
        let(:collection) { Event.all }
        let(:params) { nil }
        let(:expected) { Event.all }

        it { expect(Event.filter_by(collection, params)).to eq(expected) }
      end
    end
  end
end
