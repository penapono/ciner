# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AgeRange, type: :model do
  subject(:age_range) { build(:age_range) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :age }
  end

  describe 'methods' do
    describe 'filter_by' do
      context 'returns collection without filtering' do
        let(:collection) { AgeRange.all }
        let(:params) { nil }
        let(:expected) { AgeRange.all }

        it { expect(AgeRange.filter_by(collection, params)).to eq(expected) }
      end
    end
  end
end
