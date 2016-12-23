# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FilmProduction, type: :model do
  subject(:film_production) { build(:film_production) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :original_title }
    it { is_expected.to validate_presence_of :year }
    it { is_expected.to validate_presence_of :length }
  end

  describe '#associations' do
    it { is_expected.to belong_to :country }
    it { is_expected.to belong_to :age_range }
    it { is_expected.to belong_to :film_production_category }

    # Movie
    it { is_expected.to belong_to :studio }

    # Ciner Movie
    it { is_expected.to belong_to :approver }
    it { is_expected.to belong_to :owner }
  end
end
