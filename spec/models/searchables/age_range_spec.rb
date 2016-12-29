# frozen_string_literal: true
require 'spec_helper'

describe Searchables::AgeRange do
  subject(:searchable) { age_range }

  let(:age_range) { create(:age_range) }

  let(:expected_search_expression) do
    '
      age_ranges.name LIKE :search
    '
  end

  let(:expected_search_associations) { [] }

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
        searchable.url_helper.admin_age_ranges_path(age_range: searchable.id)
      end

      it { expect(searchable.search_link).to eq expected_search_link }
    end

    describe '#search_title' do
      let(:expected_search_title) { age_range.name }

      it { expect(searchable.search_title).to eq expected_search_title }
    end

    describe '#search_description' do
      let(:expected_search_description) { age_range.name }

      it { expect(searchable.search_description).to eq expected_search_description }
    end
  end
end
