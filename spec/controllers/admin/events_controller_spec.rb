# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  let(:user)      { create(:user, :admin) }
  let(:title)     { "Oscar" }
  let!(:events)   { create_list(:event, 2, title: title) }
  let!(:event)    { events.first }

  let(:permitted_params) do
    %i[
      title description event_date end_date start_time end_time featured
    ]
  end

  before { sign_in user }

  describe '#index' do
    describe 'template' do
      render_views
      before { get :index }

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :index }
      it { expect(controller.javascript).to eq 'views/admin/events/index' }
      it { expect(controller.stylesheet).to eq 'views/admin/events/index' }
    end

    describe 'exposes' do
      before { get :index }

      context 'all events' do
        let(:expected) { Event.all }

        it { expect(controller.events).to match(expected) }
      end
    end

    describe 'methods' do
      let(:events) { Event.all }

      context 'call' do
        before do
          allow(events).to receive(:page) { events }
          allow(events).to receive(:per) { events }
          allow(controller).to receive(:events) { events }

          get :index, params: { search: '' }
        end

        subject { controller.events }

        it { is_expected.to have_received(:page) }
        it do
          is_expected.to have_received(:per)
            .with Admin::EventsController::PER_PAGE
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
      before { get :show, params: { id: event } }
      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :show }
      it { expect(controller.javascript).to eq 'views/admin/events/show' }
      it { expect(controller.stylesheet).to eq 'views/admin/events/show' }
    end

    describe 'breadcrumbs' do
      before { get :show, params: { id: event } }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Event.model_name.human(count: 2),
            url: admin_events_path },
          { title: event.title, url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'exposes' do
      before { get :show, params: { id: event } }

      it { expect(controller.event).to eq event }
    end
  end

  describe '#new' do
    describe 'template' do
      before { get :new }

      render_views

      it { is_expected.to respond_with :success }
      it { is_expected.to render_template :new }
      it { is_expected.to render_template('_form') }
      it { expect(controller.stylesheet).to eq 'views/admin/events/new' }
      it { expect(controller.javascript).to eq 'views/admin/events/new' }
    end

    describe 'exposes' do
      before { get :new }

      it { expect(controller.event).to be_a_new(Event) }
    end

    describe 'breadcrumbs' do
      before { get :new }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Event.model_name.human(count: 2),
            url: admin_events_path },
          { title: I18n.t('admin.events.new.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end
  end

  describe '#create' do
    let(:valid_attributes) do
      build(:event, title: title).attributes
    end

    let(:invalid_attributes) do
      build(:event, :invalid).attributes
    end

    let(:valid_params)   { { event: valid_attributes } }
    let(:invalid_params) { { event: invalid_attributes } }

    describe 'breadcrumbs' do
      before { post :create, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Event.model_name.human(count: 2),
            url: admin_events_path },
          { title: I18n.t('admin.events.create.title'),
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq expected }
    end

    describe 'set_event' do
      before { post :create, params: valid_params }

      it { expect(controller.event.title).to eq title }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:create, params: params).on(:event)
      end
    end

    context 'valid params' do
      before { post :create, params: valid_params }

      let(:expected_flash) do
        I18n.t('admin.events.create.done') %
          { title: valid_params[:name] }
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { is_expected.to redirect_to action: :index }
    end

    context 'invalid params' do
      before { post :create, params: invalid_params }

      let(:expected_flash) do
        I18n.t('admin.events.create.fail') %
          { title: invalid_params[:name] }
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :new }
    end
  end

  describe '#edit' do
    let(:event) { create(:event) }

    before { get :edit, params: { id: event } }

    describe 'breadcrumbs' do
      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Event.model_name.human(count: 2),
            url: admin_events_path },
          { title: event.title,
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
      it { expect(controller.stylesheet).to eq 'views/admin/events/edit' }
      it { expect(controller.javascript).to eq 'views/admin/events/edit' }
    end

    describe 'exposes' do
      it { expect(controller.event).to eq event }
    end
  end

  describe '#update' do
    let(:event) { create(:event) }

    let(:valid_attributes) do
      event.title = title
      event.attributes
    end
    let(:invalid_attributes) do
      event = create(:event)
      event.title = nil
      event.attributes
    end

    let(:valid_params) do
      { id: valid_attributes['id'], event: valid_attributes }
    end
    let(:invalid_params) do
      { id: invalid_attributes['id'], event: invalid_attributes }
    end

    describe 'breadcrumbs' do
      before { patch :update, params: valid_params }

      let(:expected) do
        [
          { title: I18n.t('admin.home.index.title'),
            url: admin_root_path },
          { title: Event.model_name.human(count: 2),
            url: admin_events_path },
          { title: event.title,
            url: '' }
        ]
      end

      it { expect(controller.breadcrumbs).to eq(expected) }
    end

    describe 'params' do
      let(:params) { valid_params }

      it do
        is_expected.to permit(*permitted_params)
          .for(:update, params: params).on(:event)
      end
    end

    context 'valid params' do
      before { patch :update, params: valid_params }

      let(:expected_flash) do
        I18n.t('admin.events.update.done') %
          { title: valid_params[:name] }
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :show }
    end

    context 'invalid params' do
      before { patch :update, params: invalid_params }

      let(:expected_flash) do
        I18n.t('admin.events.update.fail') %
          { title: invalid_params[:name] }
      end

      it { expect(controller).to set_flash.now[:alert].to(expected_flash) }
      it { expect(response).to render_template :edit }
    end
  end

  describe '#destroy' do
    let!(:event)    { create(:event) }
    let(:error_msg) { 'error message' }

    context 'on success' do
      before { delete :destroy, params: { id: event } }

      let(:expected_flash) do
        I18n.t('admin.events.destroy.done') %
          { title: event.title }
      end

      it { expect(controller).to set_flash[:notice].to(expected_flash) }
      it { expect(response).to redirect_to action: :index }
    end

    context 'on failure' do
      let(:expected_flash) do
        I18n.t('admin.events.destroy.fail') %
          { title: event.title, error: error_msg }
      end

      before do
        allow_any_instance_of(Event).to receive(:destroy).and_return(false)
        allow_any_instance_of(ActiveModel::Errors).to receive(:full_messages)
          .and_return([error_msg])
        delete :destroy, params: { id: event }
      end

      it { expect(response).to redirect_to action: :index }
      it { expect(controller).to set_flash[:alert].to(expected_flash) }
    end
  end
end
