require 'rails_helper'

RSpec.describe CommandsController, type: :controller do
  describe '#index' do
    it 'returns ok' do
      get :index
      expect(response).to be_ok
    end

    it 'uses serializer' do
      expect(CommandSerializer).to receive(:new).and_call_original
      get :index
    end

    it 'uses policy scope' do
      expect_any_instance_of(CommandPolicy::Scope).to receive(:resolve).and_call_original
      get :index
    end

    context 'params' do
      before do
        allow_any_instance_of(CommandPolicy::Scope).to receive(:resolve).and_call_original
      end

      context 'player_id' do
        it 'uses for_player scope' do
          expect(Command).to receive(:for_player).with('1').and_call_original
          get :index, params: { player_id: 1 }
        end
      end
    end
  end
end
