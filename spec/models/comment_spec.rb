# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { create(:comment) }

  describe '#factory' do
    it { is_expected.to be_valid }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:status)
        .with(pending: 1, approved: 2, reproved: 3)

      is_expected.to define_enum_for(:origin)
        .with(ciner_comment: 1, user_comment: 2)
    end
  end

  describe '#associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :commentable }
  end

  describe '#validations' do
    it { is_expected.to validate_presence_of :content }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :commentable_id }
    it { is_expected.to validate_presence_of :commentable_type }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:user).with_prefix(true) }
  end

  describe 'methods' do
    describe 'status_str' do
      let(:expected) do
        Comment.human_attribute_name("status.#{comment.status}")
      end

      it { expect(comment.status_str).to eq expected }
    end

    describe 'origin_str' do
      let(:expected) do
        Comment.human_attribute_name("origin.#{comment.origin}")
      end

      it { expect(comment.origin_str).to eq expected }
    end

    describe 'spoiler_str' do
      let(:comment_spoiler) { create(:comment, spoiler: true) }
      let(:comment_no_spoiler) { create(:comment, spoiler: false) }

      context 'has_spoiler' do
        let(:expected) { Comment.human_attribute_name("spoiler.has_spoiler") }

        it { expect(comment_spoiler.spoiler_str).to eq(expected) }
      end

      context 'spoiler_free' do
        let(:expected) { Comment.human_attribute_name("spoiler.spoiler_free") }

        it { expect(comment_no_spoiler.spoiler_str).to eq(expected) }
      end
    end

    describe 'created_at_str' do
      let(:expected) { I18n.l(comment.created_at, format: :long) }

      it { expect(comment.created_at_str).to eq(expected) }
    end

    describe 'localized_statuses' do
      let(:expected) { [["Aguardando Aprovação", 1], ["Aprovado", 2], ["Reprovado", 3]] }

      it { expect(Comment.localized_statuses).to eq(expected) }
    end

    describe 'localized_detailed_statuses' do
      let(:expected) { [["Aguardando Aprovação", "pending"], %w(Aprovado approved), %w(Reprovado reproved)] }

      it { expect(Comment.localized_detailed_statuses).to eq(expected) }
    end

    describe 'localized_origins' do
      let(:expected) { [["Equipe Ciner", 1], ["Usuário", 2]] }

      it { expect(Comment.localized_origins).to eq(expected) }
    end

    describe 'by_origin' do
      let(:ciner_comment) { create(:comment, origin: :ciner_comment) }
      let(:user_comment) { create(:comment, origin: :user_comment) }

      context 'ciner_comment' do
        let(:param) { 1 }
        let(:expected) { [ciner_comment] }

        it { expect(Comment.by_origin(param)).to eq(expected) }
      end

      context 'user_comment' do
        let(:param) { 2 }
        let(:expected) { [user_comment] }

        it { expect(Comment.by_origin(param)).to eq(expected) }
      end
    end

    describe 'by_user_id' do
      let(:ciner_user) { create(:user, :admin) }
      let(:ciner_comment) { create(:comment, user: ciner_user) }

      let(:user) { create(:user) }
      let(:user_comment) { create(:comment, user: user) }

      context 'ciner_user' do
        let(:param) { ciner_user.id }
        let(:expected) { [ciner_comment] }

        it { expect(Comment.by_user_id(param)).to eq(expected) }
      end

      context 'user' do
        let(:param) { user.id }
        let(:expected) { [user_comment] }

        it { expect(Comment.by_user_id(param)).to eq(expected) }
      end
    end
  end

  describe 'callbacks' do
    let(:question) { create(:question) }
    let(:question_comment) { create(:comment, commentable: question) }
    let(:expected) { 1 }

    skip do
      it do
        expect(question.comments_count).to eq(expected)
      end
    end
  end
end
