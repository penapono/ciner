# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserFilmable, type: :model do
  subject(:user_filmable) { build(:user_filmable) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:action)
        .with(watched: 1, want_to_see: 2, collection: 3, favorite: 4, like: 5)
    end
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :filmable }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :filmable_id }
    it { is_expected.to validate_presence_of :filmable_type }
    it { is_expected.to validate_presence_of :action }
  end
end
