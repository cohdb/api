require 'rails_helper'

RSpec.describe ReplayPolicy do
  subject { described_class }

  let(:anon_replay) { build(:replay) }
  let(:linked_replay) { build(:replay, user_id: user.id) }
  let(:user) { build(:user, id: 1) }

  permissions :create? do
    it 'allows logged out users to create anonymous replays' do
      should permit(nil, anon_replay)
    end

    it 'does not allow logged out users to create linked replays' do
      should_not permit(nil, linked_replay)
    end

    it 'allows logged in users to link replays to themselves' do
      should permit(user, linked_replay)
    end

    it 'does not allow logged in users to link replays to other users' do
      should_not permit(user, build(:replay, user_id: 2))
    end

    it 'does not allow logged in users to create anonymous replays' do
      should_not permit(user, anon_replay)
    end
  end
end
