# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ReplaysController, type: :controller do
  describe 'pagination' do
    context 'without cursor' do
      context 'empty params' do
        it 'returns first entry sorted by descending id' do

        end
      end

      context 'limit provided' do
        it 'returns appropriate number of entries sorted by descending id' do

        end
      end

      context 'filter provided' do
        it 'filters correctly' do

        end
      end

      context 'order_by provided' do
        it 'orders by provided and then descending id' do

        end
      end

      context 'order_by overrides id order' do
        it 'orders by provided id order' do

        end
      end
    end

    context 'with cursor' do
      context 'basic id cursor' do
        it 'returns next dataset' do

        end
      end

      context 'basic id cursor with filter' do
        it 'returns next dataset properly filtered' do

        end
      end

      context 'basic id cursor with multiple filters' do
        it 'returns next dataset properly filtered' do

        end
      end

      context 'basic id cursor with limit' do
        it 'returns next dataset with limit' do

        end
      end

      context 'cursor with limit and limit param' do
        it 'returns next dataset overriding cursor limit with limit param' do

        end
      end

      context 'multiple cursors' do
        it 'returns next dataset' do

        end
      end

      context 'cursor with filter params' do
        it 'raises 400 error' do

        end
      end

      context 'cursor with order_by params' do
        it 'raises 400 error' do

        end
      end
    end
  end

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
      let!(:user) { create(:user) }
      let!(:token) { create(:access_token, resource_owner_id: user.id) }

      it 'creates a replay linked to the user' do
        expect do
          request.headers['Authorization'] = "Bearer #{token.token}"
          expect(ReplaySerializer).to receive(:new).and_call_original

          post :create, params: { replay: attributes_for(:replay, user_id: user.id) }
          expect(response).to be_ok
          expect(assigns[:replay].user).to eq(user)
        end.to change { Replay.count }.by(1)
      end
    end
  end
end
