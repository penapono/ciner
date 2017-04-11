# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Professional, type: :model do
  subject(:professional) { build(:professional) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :set_function }
    it { is_expected.to belong_to :state }
    it { is_expected.to belong_to :country }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :set_function }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:city).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:state).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:country).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:set_function).with_prefix(true) }
  end
end
