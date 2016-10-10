require 'rails_helper'

RSpec.describe State, type: :model do
  subject(:state) { build(:state) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :country }
    it { is_expected.to have_many :cities }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :country }
    it { is_expected.to validate_presence_of :acronym }
    it { is_expected.to validate_presence_of :name }

    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:country_id) }
    end
  end

  describe '#delegations' do
    it { is_expected.to delegate_method(:name).to(:country).with_prefix(true) }
  end
end
