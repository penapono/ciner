# frozen_string_literal: true

require 'spec_helper'

describe Searchables::Broadcast do
  subject(:searchable) { broadcast }

  let(:broadcast) { create(:broadcast) }

  let(:expected_search_expression) do
    '
      broadcasts.title LIKE :search OR
      broadcasts.content LIKE :search OR
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
        searchable.url_helper.admin_broadcasts_path(broadcast: searchable.id)
      end

      it { expect(searchable.search_link).to eq expected_search_link }
    end

    describe '#search_title' do
      let(:expected_search_title) { broadcast.title }

      it { expect(searchable.search_title).to eq expected_search_title }
    end

    describe '#search_description' do
      let(:expected_search_description) { broadcast.content }

      it { expect(searchable.search_description).to eq expected_search_description }
    end
  end
end
