require 'rails_helper'

RSpec.describe Studio, type: :model do
  subject(:studio) { build(:studio) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :country }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
