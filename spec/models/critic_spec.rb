# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Critic, type: :model do
  subject(:critic) { build(:critic) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:status)
        .with(pending: 1, approved: 2, reproved: 3)
    end
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

  describe 'methods' do
    describe 'status_str' do
      let(:expected) do
        Critic.human_attribute_name("status.#{critic.status}")
      end

      it { expect(critic.status_str).to eq expected }
    end

    describe 'origin_str' do
      let(:expected) do
        Critic.human_attribute_name("origin.#{critic.origin}")
      end

      it { expect(critic.origin_str).to eq expected }
    end

    describe 'name' do
      let(:expected) { critic.content.truncate(30) }

      it { expect(critic.name).to eq expected }
    end

    describe 'collapsed_content' do
      let(:expected) { critic.content.truncate(155) }

      it { expect(critic.collapsed_content).to eq expected }
    end
  end

  describe 'filters' do
  end
end
