# frozen_string_literal: true
require 'spec_helper'

describe Searchables::Critic do
  subject(:searchable) { critic }

  let(:critic) { create(:critic) }

  let(:expected_search_expression) do
    '
      critics.name LIKE :search OR
      critics.content LIKE :search OR
      cities.name LIKE :search OR
      states.name LIKE :search OR
      countries.name LIKE :search
    '
  end

  let(:expected_search_associations) { [:city, :state, :country] }

  describe 'search methods' do
    describe '#search_associations' do
      let(:search_associations) { searchable.class.search_associations }

      it { expect(search_associations).to eq expected_search_associations }
    end

    describe '#search_expression' do
      let(:search_expression) { searchable.class.search_expression }

      it { expect(search_expression.squeeze).to eq expected_search_expression.squeeze }
    end

    describe '#search_link' do
      let(:expected_search_link) do
        searchable.url_helper.admin_critics_path(critic: searchable.id)
      end

      it { expect(searchable.search_link).to eq expected_search_link }
    end

    describe '#search_title' do
      let(:expected_search_title) { critic.name }

      it { expect(searchable.search_title).to eq expected_search_title }
    end

    describe '#search_description' do
      let(:expected_search_description) { critic.content }

      it { expect(searchable.search_description).to eq expected_search_description }
    end
  end
end
