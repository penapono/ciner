require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :city }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :birthday }
    it { is_expected.to validate_presence_of :role }
    it { is_expected.to validate_presence_of :city }

    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end

  describe '#delegations' do
    it { is_expected.to delegate_method(:name).to(:city).with_prefix(true) }
  end
end
