# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CinerNew, type: :model do
  subject(:ciner_new) { build(:ciner_new) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :city }
    it { is_expected.to belong_to :state }
    it { is_expected.to belong_to :country }
    it { is_expected.to belong_to :user }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :user }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:city).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:state).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:country).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
  end
end
