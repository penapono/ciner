# frozen_string_literal: true

require 'spec_helper'

describe Searchables::Professional do
  subject(:searchable) { professional }

  let(:professional) { create(:professional) }

  let(:expected_search_expression) do
    '
      professionals.name LIKE :search OR
      professionals.nickname LIKE :search OR
      professionals.cep LIKE :search OR
      professionals.neighbourhood LIKE :search OR
      professionals.complement LIKE :search OR
      professionals.cpf LIKE :search OR
      professionals.phone LIKE :search OR
      professionals.mobile LIKE :search OR
      professionals.biography LIKE :search OR
      cities.name LIKE :search OR
      states.name LIKE :search OR
      countries.name LIKE :search
    '
  end

  let(:expected_search_associations) { %i[city state country] }

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
        searchable.url_helper.admin_professionals_path(professional: searchable.id)
      end

      it { expect(searchable.search_link).to eq expected_search_link }
    end

    describe '#search_title' do
      let(:expected_search_title) { professional.name }

      it { expect(searchable.search_title).to eq expected_search_title }
    end

    describe '#search_description' do
      let(:expected_search_description) { professional.biography }

      it { expect(searchable.search_description).to eq expected_search_description }
    end
  end
end
