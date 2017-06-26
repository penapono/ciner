# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CriticsController, type: :controller do
  let(:user) { create(:user, :admin) }
  let!(:critics) { create_list(:critic, 2, user: user) }
  let!(:critic)  { critics.first }

  let(:permitted_params) do
    %i[
      content user_id filmable_id filmable_type
      filmable rating status origin featured
      spoiler quick
    ]
  end

  before { sign_in user }

  describe '#index' do
    describe 'template' do
      render_views
      before { get :index }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :index }
      it { expect(controller.javascript).to eq 'views/admin/critics/index' }
      it { expect(controller.stylesheet).to eq 'views/admin/critics/index' }
    end

    describe 'exposes' do
      before { get :index }

      context 'critics ordered by status' do
        let(:expected) { Critic.ordered_by_status }

        it { expect(controller.critics).to match(expected) }
      end
    end

    describe 'methods' do
      let(:critics) { Critic.ordered_by_status }

      context 'call' do
        before do
          allow(critics).to receive(:page) { critics }
          allow(critics).to receive(:per) { critics }
          allow(controller).to receive(:critics) { critics }

          get :index, params: { search: '' }
        end

        subject { controller.critics }

        it { is_expected.to have_received(:page) }
        it do
          is_expected.to have_received(:per)
            .with Admin::CriticsController::PER_PAGE
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
      before { get :show, params: { id: critic } }
      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :show }
      it { expect(controller.javascript).to eq 'views/admin/critics/show' }
      it { expect(controller.stylesheet).to eq 'views/admin/critics/show' }
    end

    describe 'breadcrumbs' do
      before { get :show, params: { id: critic } }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: I18n.t('admin.critics.index.title'),
            url: admin_critics_path },
          { title: critic.name, url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'exposes' do
      before { get :show, params: { id: critic } }

      it { expect(controller.critic).to eq critic }
    end
  end

  describe '#new' do
    describe 'template' do
      before { get :new }

      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :new }
      it { is_expected.to render_template('_form') }
      it { expect(controller.stylesheet).to eq 'views/admin/critics/new' }
      it { expect(controller.javascript).to eq 'views/admin/critics/new' }
    end

    describe 'exposes' do
      before { get :new }

      it { expect(controller.critic).to be_a_new(Critic) }
    end

    describe 'breadcrumbs' do
      before { get :new }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: I18n.t('admin.critics.index.title'),
            url: admin_critics_path },
          { title: I18n.t('admin.critics.new.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end
  end

  describe '#create' do
    let(:valid_attributes) do
      build(:critic, user: user).attributes
    end

    let(:invalid_attributes) do
      build(:critic, :invalid, user: user).attributes
    end

    let(:valid_params)   { { critic: valid_attributes } }
    let(:invalid_params) { { critic: invalid_attributes } }

    describe 'breadcrumbs' do
      before { post :create, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: I18n.t('admin.critics.index.title'),
            url: admin_critics_path },
          { title: I18n.t('admin.critics.create.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'set_critic' do
      before { post :create, params: valid_params }

      it { expect(controller.critic.user).to eq user }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:create, params: params).on(:critic)
      end
    end

    context 'valid params' do
      before { post :create, params: valid_params }

      let(:expected_flash) do
        format(I18n.t('admin.critics.create.done'), title: valid_params[:name])
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { is_expected.to redirect_to action: :index }
    end

    context 'invalid params' do
      before { post :create, params: invalid_params }

      let(:expected_flash) do
        format(I18n.t('admin.critics.create.fail'), title: invalid_params[:name])
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :new }
    end
  end

  describe '#edit' do
    let(:critic) { create(:critic, user: user) }

    before { get :edit, params: { id: critic } }

    describe 'breadcrumbs' do
      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: I18n.t('admin.critics.index.title'),
            url: admin_critics_path },
          { title: critic.name,
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
      it { expect(controller.stylesheet).to eq 'views/admin/critics/edit' }
      it { expect(controller.javascript).to eq 'views/admin/critics/edit' }
    end

    describe 'exposes' do
      it { expect(controller.critic).to eq critic }
    end
  end

  describe '#update' do
    let(:critic) { create(:critic, user: user) }

    let(:valid_attributes) do
      critic.attributes
    end
    let(:invalid_attributes) do
      critic = create(:critic, user: user)
      critic.content = nil
      critic.attributes
    end

    let(:valid_params) do
      { id: valid_attributes['id'], critic: valid_attributes }
    end
    let(:invalid_params) do
      { id: invalid_attributes['id'], critic: invalid_attributes }
    end

    describe 'breadcrumbs' do
      before { patch :update, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: I18n.t('admin.critics.index.title'),
            url: admin_critics_path },
          { title: critic.name,
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:update, params: params).on(:critic)
      end
    end

    context 'valid params' do
      before { patch :update, params: valid_params }

      let(:expected_flash) do
        format(I18n.t('admin.critics.update.done'), title: valid_params[:name])
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :show }
    end

    context 'invalid params' do
      before { patch :update, params: invalid_params }

      let(:expected_flash) do
        format(I18n.t('admin.critics.update.fail'), title: invalid_params[:name])
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:critic) { create(:critic, user: user) }
    let(:error_msg) { 'error message' }

    context 'on success' do
      before { delete :destroy, params: { id: critic } }

      let(:expected_flash) do
        format(I18n.t('admin.critics.destroy.done'), title: critic.name)
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :index }
    end

    context 'on failure' do
      let(:expected_flash) do
        format(I18n.t('admin.critics.destroy.fail'), title: critic.name, error: error_msg)
      end

      before do
        allow_any_instance_of(Critic).to receive(:destroy).and_return(false)
        allow_any_instance_of(ActiveModel::Errors).to receive(:full_messages)
          .and_return([error_msg])
        delete :destroy, params: { id: critic }
      end

      it { expect(response).to redirect_to action: :index }
      it { expect(controller).to set_flash[:alert].to(expected_flash) }
    end
  end
end
