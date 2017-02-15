# frozen_string_literal: true
require 'spec_helper'

describe Searchables::Question do
  subject(:searchable) { question }

  let(:question) { create(:question) }

  let(:expected_search_expression) do
    '
      questions.title LIKE :search OR
      questions.content LIKE :search OR
      users.name LIKE :search
    '
  end

  let(:expected_search_associations) { [:user] }

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
        searchable.url_helper.admin_questions_path(question: searchable.id)
      end

      it { expect(searchable.search_link).to eq expected_search_link }
    end

    describe '#search_title' do
      let(:expected_search_title) { question.title }

      it { expect(searchable.search_title).to eq expected_search_title }
    end

    describe '#search_description' do
      let(:expected_search_description) { question.content }

      it { expect(searchable.search_description).to eq expected_search_description }
    end
  end
end
