# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Broadcast, type: :model do
  subject(:broadcast) { create(:broadcast) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :user }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
  end

  describe 'methods' do
    describe 'filter_by' do
      context 'returns collection without filtering' do
        let(:collection) { Broadcast.all }
        let(:params) { nil }
        let(:expected) { Broadcast.all }

        it { expect(Broadcast.filter_by(collection, params)).to eq(expected) }
      end
    end

    describe 'spoiler_str' do
      let(:broadcast_spoiler) { create(:broadcast, spoiler: true) }
      let(:broadcast_no_spoiler) { create(:broadcast, spoiler: false) }

      context 'has_spoiler' do
        let(:expected) { Broadcast.human_attribute_name("spoiler.has_spoiler") }

        it { expect(broadcast_spoiler.spoiler_str).to eq(expected) }
      end

      context 'spoiler_free' do
        let(:expected) { Broadcast.human_attribute_name("spoiler.spoiler_free") }

        it { expect(broadcast_no_spoiler.spoiler_str).to eq(expected) }
      end
    end

    describe 'created_at_str' do
      let(:expected) { I18n.l(broadcast.created_at, format: :long) }

      it { expect(broadcast.created_at_str).to eq(expected) }
    end
  end
end
