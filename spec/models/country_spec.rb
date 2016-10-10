require 'rails_helper'

RSpec.describe Country, type: :model do
  subject(:country) { build(:country) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to have_many :states }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :acronym }
    it { is_expected.to validate_presence_of :name }

    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
