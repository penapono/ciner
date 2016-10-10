require 'rails_helper'

RSpec.describe City, type: :model do
  subject(:city) { build(:city) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :state }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :state }
    it { is_expected.to validate_presence_of :name }

    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:state_id) }
    end
  end

  describe '#delegations' do
    it { is_expected.to delegate_method(:name).to(:state).with_prefix(true) }
  end
end
