# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SetFunction, type: :model do
  subject(:set_function) { build(:set_function) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }

    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
