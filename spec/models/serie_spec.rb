# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Serie, type: :model do
  subject(:serie) { build(:serie) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :original_title }
    it { is_expected.to validate_presence_of :year }
    it { is_expected.to validate_presence_of :length }
  end

  describe '#associations' do
    it { is_expected.to belong_to :city }
    it { is_expected.to belong_to :state }
    it { is_expected.to belong_to :country }
    it { is_expected.to belong_to :age_range }

    it { is_expected.to belong_to :studio }

    describe 'mounts' do
      it { expect(serie.cover).to be_a(CoverUploader) }
    end
  end

  describe '#delegations' do
    it { is_expected.to delegate_method(:name).to(:city).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:state).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:country).with_prefix(true) }
  end
end
