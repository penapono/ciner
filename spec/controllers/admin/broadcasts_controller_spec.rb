# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::BroadcastsController, type: :controller do
  let(:user) { create(:user, :admin) }
  let!(:broadcasts) { create_list(:broadcast, 2, user: user) }
  let!(:broadcast)  { broadcasts.first }

  let(:permitted_params) do
    %i[
      title content user_id spoiler featured
    ]
  end

  before { sign_in user }

  describe '#index' do
    describe 'template' do
      render_views
      before { get :index }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :index }
      it { expect(controller.javascript).to eq 'views/admin/broadcasts/index' }
      it { expect(controller.stylesheet).to eq 'views/admin/broadcasts/index' }
    end

    describe 'exposes' do
      before { get :index }

      context 'broadcasts ordered by status' do
        let(:expected) { Broadcast.last_created }

        it { expect(controller.broadcasts).to match(expected) }
      end
    end

    describe 'methods' do
      let(:broadcasts) { Broadcast.last_created }

      context 'call' do
        before do
          allow(broadcasts).to receive(:page) { broadcasts }
          allow(broadcasts).to receive(:per) { broadcasts }
          allow(controller).to receive(:broadcasts) { broadcasts }

          get :index, params: { search: '' }
        end

        subject { controller.broadcasts }

        it { is_expected.to have_received(:page) }
        it do
          is_expected.to have_received(:per)
            .with Admin::BroadcastsController::PER_PAGE
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
      before { get :show, params: { id: broadcast } }
      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :show }
      it { expect(controller.javascript).to eq 'views/admin/broadcasts/show' }
      it { expect(controller.stylesheet).to eq 'views/admin/broadcasts/show' }
    end

    describe 'breadcrumbs' do
      before { get :show, params: { id: broadcast } }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Broadcast.model_name.human(count: 2),
            url: admin_broadcasts_path },
          { title: broadcast.title, url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'exposes' do
      before { get :show, params: { id: broadcast } }

      it { expect(controller.broadcast).to eq broadcast }
    end
  end

  describe '#new' do
    describe 'template' do
      before { get :new }

      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :new }
      it { is_expected.to render_template('_form') }
      it { expect(controller.stylesheet).to eq 'views/admin/broadcasts/new' }
      it { expect(controller.javascript).to eq 'views/admin/broadcasts/new' }
    end

    describe 'exposes' do
      before { get :new }

      it { expect(controller.broadcast).to be_a_new(Broadcast) }
    end

    describe 'breadcrumbs' do
      before { get :new }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Broadcast.model_name.human(count: 2),
            url: admin_broadcasts_path },
          { title: I18n.t('admin.broadcasts.new.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end
  end

  describe '#create' do
    let(:valid_attributes) do
      build(:broadcast, user: user).attributes
    end

    let(:invalid_attributes) do
      build(:broadcast, :invalid, user: user).attributes
    end

    let(:valid_params)   { { broadcast: valid_attributes } }
    let(:invalid_params) { { broadcast: invalid_attributes } }

    describe 'breadcrumbs' do
      before { post :create, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Broadcast.model_name.human(count: 2),
            url: admin_broadcasts_path },
          { title: I18n.t('admin.broadcasts.create.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'set_broadcast' do
      before { post :create, params: valid_params }

      it { expect(controller.broadcast.user).to eq user }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:create, params: params).on(:broadcast)
      end
    end

    context 'valid params' do
      before { post :create, params: valid_params }

      let(:expected_flash) do
        format(I18n.t('admin.broadcasts.create.done'), title: valid_params[:name])
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { is_expected.to redirect_to action: :index }
    end

    context 'invalid params' do
      before { post :create, params: invalid_params }

      let(:expected_flash) do
        format(I18n.t('admin.broadcasts.create.fail'), title: invalid_params[:name])
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :new }
    end
  end

  describe '#edit' do
    let(:broadcast) { create(:broadcast, user: user) }

    before { get :edit, params: { id: broadcast } }

    describe 'breadcrumbs' do
      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Broadcast.model_name.human(count: 2),
            url: admin_broadcasts_path },
          { title: broadcast.title,
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
      it { expect(controller.stylesheet).to eq 'views/admin/broadcasts/edit' }
      it { expect(controller.javascript).to eq 'views/admin/broadcasts/edit' }
    end

    describe 'exposes' do
      it { expect(controller.broadcast).to eq broadcast }
    end
  end

  describe '#update' do
    let(:broadcast) { create(:broadcast, user: user) }

    let(:valid_attributes) do
      broadcast.attributes
    end
    let(:invalid_attributes) do
      broadcast = create(:broadcast, user: user)
      broadcast.content = nil
      broadcast.attributes
    end

    let(:valid_params) do
      { id: valid_attributes['id'], broadcast: valid_attributes }
    end
    let(:invalid_params) do
      { id: invalid_attributes['id'], broadcast: invalid_attributes }
    end

    describe 'breadcrumbs' do
      before { patch :update, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Broadcast.model_name.human(count: 2),
            url: admin_broadcasts_path },
          { title: broadcast.title,
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:update, params: params).on(:broadcast)
      end
    end

    context 'valid params' do
      before { patch :update, params: valid_params }

      let(:expected_flash) do
        format(I18n.t('admin.broadcasts.update.done'), title: valid_params[:name])
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :show }
    end

    context 'invalid params' do
      before { patch :update, params: invalid_params }

      let(:expected_flash) do
        format(I18n.t('admin.broadcasts.update.fail'), title: invalid_params[:name])
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:broadcast) { create(:broadcast, user: user) }
    let(:error_msg) { 'error message' }

    context 'on success' do
      before { delete :destroy, params: { id: broadcast } }

      let(:expected_flash) do
        format(I18n.t('admin.broadcasts.destroy.done'), title: broadcast.title)
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :index }
    end

    context 'on failure' do
      let(:expected_flash) do
        format(I18n.t('admin.broadcasts.destroy.fail'), title: broadcast.title, error: error_msg)
      end

      before do
        allow_any_instance_of(Broadcast).to receive(:destroy).and_return(false)
        allow_any_instance_of(ActiveModel::Errors).to receive(:full_messages)
          .and_return([error_msg])
        delete :destroy, params: { id: broadcast }
      end

      it { expect(response).to redirect_to action: :index }
      it { expect(controller).to set_flash[:alert].to(expected_flash) }
    end
  end
end
