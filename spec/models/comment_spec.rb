# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { build(:comment) }

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
    it { is_expected.to belong_to :commentable }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :commentable_id }
    it { is_expected.to validate_presence_of :commentable_type }
    it { is_expected.to validate_presence_of :user }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
  end

  describe 'methods' do
    describe 'status_str' do
      let(:expected) do
        Comment.human_attribute_name("status.#{comment.status}")
      end

      it { expect(comment.status_str).to eq expected }
    end

    describe 'origin_str' do
      let(:expected) do
        Comment.human_attribute_name("origin.#{comment.origin}")
      end

      it { expect(comment.origin_str).to eq expected }
    end
  end
end
