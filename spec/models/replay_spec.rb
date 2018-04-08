# frozen_string_literal: true
# == Schema Information
#
# Table name: replays
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  version          :integer          not null
#  length           :integer          not null
#  map              :string           not null
#  rng_seed         :integer
#  opponent_type    :string
#  game_type        :string
#  recorded_at      :datetime
#  rec_file_name    :string
#  rec_content_type :string
#  rec_file_size    :integer
#  rec_updated_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recorded_at_text :string           default(""), not null
#
# Indexes
#
#  index_replays_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Replay, type: :model do
  describe 'validations' do
    subject { build(:replay) }

    it 'has a valid factory' do
      should be_valid
    end

    it 'is invalid without an opponent type' do
      subject.opponent_type = nil
      should be_invalid
    end

    it 'is invalid with an incorrect opponent type' do
      subject.opponent_type = 'Bad Type'
      should be_invalid
    end

    it 'is invalid without a game type' do
      subject.game_type = nil
      should be_invalid
    end

    it 'is invalid with an incorrect game type' do
      subject.game_type = 'Bad Type'
      should be_invalid
    end

    it 'is invalid without a map' do
      subject.map = nil
      should be_invalid
    end

    it 'is invalid without recorded at text' do
      subject.recorded_at_text = nil
      should be_invalid
    end

    it 'is invalid without a version' do
      subject.version = nil
      should be_invalid
    end

    it 'is invalid with a non-integer version number' do
      subject.version = 1.5
      should be_invalid
    end

    it 'is invalid with a negative version number' do
      subject.version = -1
      should be_invalid
    end

    it 'is invalid with a version number of 0' do
      subject.version = 0
      should be_invalid
    end

    it 'is valid with a natural version number' do
      subject.version = 1
      should be_valid
    end

    it 'is invalid without a length' do
      subject.length = nil
      should be_invalid
    end

    it 'is invalid with a non-integer length' do
      subject.length = 1.5
      should be_invalid
    end

    it 'is invalid with a negative length' do
      subject.length = -1
      should be_invalid
    end

    it 'is valid with a length of 0' do
      subject.length = 0
      should be_valid
    end

    it 'is valid with a positive length' do
      subject.length = 1
      should be_valid
    end

    it 'is invalid without a replay file attached' do
      subject.rec = nil
      should be_invalid
    end

    it 'is invalid with a non-replay file attached' do
      subject.rec = File.new(Rails.root.join('spec', 'support', 'fixtures', 'test_image.jpg'))
      should be_invalid
    end
  end

  describe '.map_resource_id' do
    let(:replay) { build(:replay, map: '$123') }
    subject { replay.map_resource_id }

    it 'strips $ from start of map ID' do
      expect(subject).to eq('123')
    end
  end

  describe '.map_name' do
    let(:replay) { build(:replay, map: map) }
    subject { replay.map_name }

    context 'known map ID' do
      let(:map) { '$known' }

      before do
        allow(Relic::Resources::Collection).to receive(:resource_text).with('known', :english).and_return('Known Map')
      end

      it 'returns English localized string for that map' do
        expect(subject).to eq('Known Map')
      end
    end

    context 'unknown map ID' do
      let(:map) { '$unknown' }

      it 'returns Unknown placeholder' do
        expect(subject).to eq('Unknown')
      end
    end
  end

  describe 'pagination' do
    describe '#filter' do
      let!(:replay) { create(:replay, :with_user) }

      before do
        create(:replay)
      end

      subject { described_class.filter(params) }

      context 'with blank params' do
        let(:params) { {} }

        it 'returns all entities' do
          expect(subject.count).to eq(Replay.count)
        end
      end

      context 'with filter params' do
        let(:params) { { user_id: replay.user.id } }

        it 'filters based on params' do
          expect(subject).to contain_exactly(replay)
        end
      end

      context 'with cursor' do
        let(:params) { { cursor: Base64.encode64("user_id|#{replay.user.id}") } }

        it 'filters based on cursor' do
          expect(subject).to contain_exactly(replay)
        end
      end

      context 'with cursor and filter params' do
        let(:params) { { cursor: Base64.encode64("user_id|#{replay.user.id}"), user_id: replay.user.id } }

        it 'raises 400 error' do
          expect { subject }.to raise_exception
        end
      end
    end

    describe '#order_by' do
      let(:user) { create(:user) }
      let!(:second_replay) { create(:replay, user: user, created_at: second_date) }
      let!(:first_replay) { create(:replay, user: user, created_at: first_date) }

      subject { described_class.filter(user_id: user.id).order_by(params) }

      context 'order column values are different' do
        let(:first_date) { 1.week.ago }
        let(:second_date) { 1.week.from_now }

        context 'with order params' do
          context 'implicit direction' do
            let(:params) { { order_by: 'created_at' } }

            it 'orders in ascending direction' do
              expect(subject).to contain_exactly(first_replay, second_replay)
              expect(subject.first).to eq(first_replay)
            end
          end

          context 'explicit asc direction' do
            let(:params) { { order_by: 'created_at|asc' } }

            it 'orders correctly' do
              expect(subject).to contain_exactly(first_replay, second_replay)
              expect(subject.first).to eq(first_replay)
            end
          end

          context 'explicit desc direction' do
            let(:params) { { order_by: 'created_at|desc' } }

            it 'orders correctly' do
              expect(subject).to contain_exactly(first_replay, second_replay)
              expect(subject.first).to eq(second_replay)
            end
          end
        end

        context 'with cursor' do
          context 'asc direction' do
            let(:params) { { cursor: Base64.encode64('created_at|1|asc') } }

            it 'orders correctly' do
              expect(subject).to contain_exactly(first_replay, second_replay)
              expect(subject.first).to eq(first_replay)
            end
          end

          context 'desc direction' do
            let(:params) { { cursor: Base64.encode64('created_at|1|desc') } }

            it 'orders correctly' do
              expect(subject).to contain_exactly(first_replay, second_replay)
              expect(subject.first).to eq(second_replay)
            end
          end
        end
      end

      context 'order column values are the same' do
        let(:first_date) { 1.week.ago }
        let(:second_date) { first_date }

        context 'with order params' do
          let(:params) { { order_by: 'created_at' } }

          it 'suborders by descending id' do
            expect(subject).to contain_exactly(first_replay, second_replay)
            expect(subject.first).to eq(first_replay)
          end
        end

        context 'with cursor' do
          let(:params) { { cursor: Base64.encode64('created_at|1|desc,id|1|asc') } }

          it 'suborders by the next order in the cursor' do
            expect(subject).to contain_exactly(first_replay, second_replay)
            expect(subject.first).to eq(second_replay)
          end
        end
      end

      context 'with cursor and order params' do
        let(:first_date) { 1.week.ago }
        let(:second_date) { 1.week.from_now }
        let(:params) { { cursor: Base64.encode64('created_at|1|desc'), order_by: 'created_at' } }

        it 'raises 400 error' do
          expect { subject }.to raise_exception
        end
      end
    end

    describe '#page' do
      subject { described_class.page(params.merge(limit: 1)) }

      context 'without cursor' do
        let!(:replays) { create_list(:replay, 2) }
        let(:params) { {} }

        it 'applies a limit to the dataset' do
          expect(subject).to contain_exactly(replays.first)
        end
      end

      context 'with cursor' do
        let!(:previous) { create(:replay, created_at: previous_date) }
        let!(:first_replay) { create(:replay, created_at: first_date) }
        let!(:second_replay) { create(:replay, created_at: second_date) }

        context 'basic id ordering' do
          let(:previous_date) { 1.week.ago }
          let(:first_date) { previous_date }
          let(:second_date) { previous_date }
          let(:params) { { cursor: Base64.encode64("id|#{previous.id}|asc") } }

          it 'returns next page of entries' do
            expect(subject).to contain_exactly(first_replay)
          end
        end

        context 'complex ordering' do
          let(:params) { { cursor: Base64.encode64("created_at|#{previous.created_at}|desc,id|#{previous.id}|asc") } }

          context 'order columns are different' do
            let(:previous_date) { 1.week.from_now }
            let(:first_date) { 1.week.ago }
            let(:second_date) { 2.weeks.ago }

            it 'returns next page of entries' do
              expect(subject).to contain_exactly(first_replay)
            end
          end

          context 'order column of next is same as that of previous' do
            let(:previous_date) { 1.week.from_now }
            let(:first_date) { previous_date }
            let(:second_date) { 1.week.ago }

            it 'returns next page of entries' do
              expect(subject).to contain_exactly(first_replay)
            end
          end

          context 'order column of next two are the same' do
            let(:previous_date) { 1.week.from_now }
            let(:first_date) { 1.week.ago }
            let(:second_date) { first_date }

            it 'returns next page of entries' do
              expect(subject).to contain_exactly(first_replay)
            end
          end
        end
      end
    end
  end
end
