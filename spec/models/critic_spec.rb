# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Critic, type: :model do
  subject(:critic) { build(:critic) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :filmable }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :filmable_id }
    it { is_expected.to validate_presence_of :filmable_type }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :rating }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
    it { is_expected.to delegate_method(:title_str).to(:filmable).with_prefix(true) }
    it { is_expected.to delegate_method(:original_title).to(:filmable).with_prefix(true) }
    it { is_expected.to delegate_method(:cover).to(:filmable).with_prefix(true) }
  end
end
