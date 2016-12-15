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
end
