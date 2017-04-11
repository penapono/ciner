# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::AgeRangesController, type: :controller do
  let(:user)        { create(:user, :admin) }
  let(:age)         { 18 }
  let!(:age_ranges) { create_list(:age_range, 2) }
  let!(:age_range)  { age_ranges.first }

  let(:permitted_params) do
    %i[
      name age
    ]
  end

  before { sign_in user }

  describe '#index' do
    describe 'template' do
      render_views
      before { get :index }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :index }
      it { expect(controller.javascript).to eq 'views/admin/age_ranges/index' }
      it { expect(controller.stylesheet).to eq 'views/admin/age_ranges/index' }
    end

    describe 'exposes' do
      before { get :index }

      context 'age_ranges ordered by status' do
        let(:expected) { AgeRange.order(age: :asc) }

        it { expect(controller.age_ranges).to match(expected) }
      end
    end

    describe 'methods' do
      let(:age_ranges) { AgeRange.order(age: :asc) }

      context 'call' do
        before do
          allow(age_ranges).to receive(:page) { age_ranges }
          allow(age_ranges).to receive(:per) { age_ranges }
          allow(controller).to receive(:age_ranges) { age_ranges }

          get :index, params: { search: '' }
        end

        subject { controller.age_ranges }

        it { is_expected.to have_received(:page) }
        it do
          is_expected.to have_received(:per)
            .with Admin::AgeRangesController::PER_PAGE
        end
      end
    end

    skip do
      describe 'filters' do
      end
    end
  end

  describe '#show' do
    describe 'template' do
      before { get :show, params: { id: age_range } }
      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :show }
      it { expect(controller.javascript).to eq 'views/admin/age_ranges/show' }
      it { expect(controller.stylesheet).to eq 'views/admin/age_ranges/show' }
    end

    describe 'breadcrumbs' do
      before { get :show, params: { id: age_range } }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: AgeRange.model_name.human(count: 2),
            url: admin_age_ranges_path },
          { title: age_range.name, url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'exposes' do
      before { get :show, params: { id: age_range } }

      it { expect(controller.age_range).to eq age_range }
    end
  end

  describe '#new' do
    describe 'template' do
      before { get :new }

      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :new }
      it { is_expected.to render_template('_form') }
      it { expect(controller.stylesheet).to eq 'views/admin/age_ranges/new' }
      it { expect(controller.javascript).to eq 'views/admin/age_ranges/new' }
    end

    describe 'exposes' do
      before { get :new }

      it { expect(controller.age_range).to be_a_new(AgeRange) }
    end

    describe 'breadcrumbs' do
      before { get :new }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: AgeRange.model_name.human(count: 2),
            url: admin_age_ranges_path },
          { title: I18n.t('admin.age_ranges.new.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end
  end

  describe '#create' do
    let(:valid_attributes) do
      build(:age_range).attributes
    end

    let(:invalid_attributes) do
      build(:age_range, :invalid).attributes
    end

    let(:valid_params)   { { age_range: valid_attributes } }
    let(:invalid_params) { { age_range: invalid_attributes } }

    describe 'breadcrumbs' do
      before { post :create, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: AgeRange.model_name.human(count: 2),
            url: admin_age_ranges_path },
          { title: I18n.t('admin.age_ranges.create.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'set_age_range' do
      before { post :create, params: valid_params }

      it { expect(controller.age_range.age).to eq age }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:create, params: params).on(:age_range)
      end
    end

    context 'valid params' do
      before { post :create, params: valid_params }

      let(:expected_flash) do
        I18n.t('admin.age_ranges.create.done') %
          { title: valid_params[:name] }
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { is_expected.to redirect_to action: :index }
    end

    context 'invalid params' do
      before { post :create, params: invalid_params }

      let(:expected_flash) do
        I18n.t('admin.age_ranges.create.fail') %
          { title: invalid_params[:name] }
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :new }
    end
  end

  describe '#edit' do
    let(:age_range) { create(:age_range) }

    before { get :edit, params: { id: age_range } }

    describe 'breadcrumbs' do
      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: AgeRange.model_name.human(count: 2),
            url: admin_age_ranges_path },
          { title: age_range.name,
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end

    describe 'template' do
      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :edit }
      it { is_expected.to render_template('_form') }
      it { expect(controller.stylesheet).to eq 'views/admin/age_ranges/edit' }
      it { expect(controller.javascript).to eq 'views/admin/age_ranges/edit' }
    end

    describe 'exposes' do
      it { expect(controller.age_range).to eq age_range }
    end
  end

  describe '#update' do
    let(:age_range) { create(:age_range) }

    let(:valid_attributes) do
      age_range.age = age
      age_range.attributes
    end
    let(:invalid_attributes) do
      age_range = create(:age_range)
      age_range.age = nil
      age_range.attributes
    end

    let(:valid_params) do
      { id: valid_attributes['id'], age_range: valid_attributes }
    end
    let(:invalid_params) do
      { id: invalid_attributes['id'], age_range: invalid_attributes }
    end

    describe 'breadcrumbs' do
      before { patch :update, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: AgeRange.model_name.human(count: 2),
            url: admin_age_ranges_path },
          { title: age_range.name,
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:update, params: params).on(:age_range)
      end
    end

    context 'valid params' do
      before { patch :update, params: valid_params }

      let(:expected_flash) do
        I18n.t('admin.age_ranges.update.done') %
          { title: valid_params[:name] }
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :show }
    end

    context 'invalid params' do
      before { patch :update, params: invalid_params }

      let(:expected_flash) do
        I18n.t('admin.age_ranges.update.fail') %
          { title: invalid_params[:name] }
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:age_range) { create(:age_range) }
    let(:error_msg) { 'error message' }

    context 'on success' do
      before { delete :destroy, params: { id: age_range } }

      let(:expected_flash) do
        I18n.t('admin.age_ranges.destroy.done') %
          { title: age_range.name }
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :index }
    end

    context 'on failure' do
      let(:expected_flash) do
        I18n.t('admin.age_ranges.destroy.fail') %
          { title: age_range.name, error: error_msg }
      end

      before do
        allow_any_instance_of(AgeRange).to receive(:destroy).and_return(false)
        allow_any_instance_of(ActiveModel::Errors).to receive(:full_messages)
          .and_return([error_msg])
        delete :destroy, params: { id: age_range }
      end

      it { expect(response).to redirect_to action: :index }
      it { expect(controller).to set_flash[:alert].to(expected_flash) }
    end
  end
end
