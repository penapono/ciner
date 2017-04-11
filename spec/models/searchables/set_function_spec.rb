# frozen_string_literal: true

require 'spec_helper'

describe Searchables::SetFunction do
  subject(:searchable) { set_function }

  let(:set_function) { create(:set_function) }

  let(:expected_search_expression) do
    '
      set_functions.name LIKE :search OR
      set_functions.description LIKE :search
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
        searchable.url_helper.admin_set_functions_path(set_function: searchable.id)
      end

      it { expect(searchable.search_link).to eq expected_search_link }
    end

    describe '#search_title' do
      let(:expected_search_title) { set_function.name }

      it { expect(searchable.search_title).to eq expected_search_title }
    end

    describe '#search_description' do
      let(:expected_search_description) { set_function.description }

      it { expect(searchable.search_description).to eq expected_search_description }
    end
  end
end
