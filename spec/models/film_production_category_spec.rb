require 'rails_helper'

RSpec.describe FilmProductionCategory, type: :model do
  subject(:film_production_category) { build(:film_production_category) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :name }
  end
end
