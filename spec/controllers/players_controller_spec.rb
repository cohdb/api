require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  describe '#index' do
    it 'returns ok' do
      get :index
      expect(response).to be_ok
    end

    it 'uses serializer' do
      expect(PlayerSerializer).to receive(:new).and_call_original
      get :index
    end

    it 'uses policy scope' do
      expect_any_instance_of(PlayerPolicy::Scope).to receive(:resolve).and_call_original
      get :index
    end

    context 'params' do
      before do
        allow_any_instance_of(PlayerPolicy::Scope).to receive(:resolve).and_call_original
      end

      context 'replay_id' do
        it 'uses for_replay scope' do
          expect(Player).to receive(:for_replay).with('1').and_call_original
          get :index, params: { replay_id: 1 }
        end
      end
    end
  end
end
