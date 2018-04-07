require 'rails_helper'

RSpec.describe ReplaysController do
  describe '#index' do
    it 'returns ok' do
      get :index
      expect(response).to be_ok
    end

    it 'uses serializer' do
      expect(ReplaySerializer).to receive(:new).and_call_original
      get :index
    end

    it 'uses policy scope' do
      expect_any_instance_of(ReplayPolicy::Scope).to receive(:resolve).and_call_original
      get :index
    end
  end

  describe '#show' do
    context 'invalid ID' do
      it 'returns not found' do
        get :show, params: { id: 1 }
        expect(response).to be_not_found
      end
    end

    context 'valid ID' do
      let!(:replay) { create(:replay) }

      it 'functions as expected' do
        expect_any_instance_of(ReplayPolicy::Scope).to receive(:resolve).and_call_original
        expect(ReplaySerializer).to receive(:new).and_call_original

        get :show, params: { id: replay.id }
        expect(response).to be_ok
        expect(assigns[:replay]).to eq(replay)
      end
    end
  end

  describe '#create' do
    context 'logged out user' do
      it 'creates an anonymous replay' do
        expect do
          expect(ReplaySerializer).to receive(:new).and_call_original

          post :create, params: { replay: attributes_for(:replay) }
          expect(response).to be_ok
        end.to change { Replay.count }.by(1)
      end
    end

    context 'logged in user' do
      # TODO
    end
  end
end
