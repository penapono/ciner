# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject(:movie) { build(:movie) }

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
  end

  describe 'methods' do
    describe 'title_str' do
      let(:title) { 'Título' }
      let(:original_title) { 'Título Original' }
      let(:movie_with_title) { create(:movie, title: title, original_title: original_title) }
      let(:movie_without_title) { create(:movie, title: '', original_title: original_title) }

      context 'movie with title' do
        it { expect(movie_with_title.title_str).to eq(title) }
      end

      context 'movie without title' do
        it { expect(movie_without_title.title_str).to eq(original_title) }
      end
    end
  end

  describe '#delegations' do
    it { is_expected.to delegate_method(:name).to(:city).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:state).with_prefix(true) }
    it { is_expected.to delegate_method(:name).to(:country).with_prefix(true) }
  end
end
