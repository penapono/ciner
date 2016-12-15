require 'rails_helper'

RSpec.describe Professional, type: :model do
  subject(:professional) { build(:professional) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :set_function }
    it { is_expected.to belong_to :country }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :set_function }
  end
end
