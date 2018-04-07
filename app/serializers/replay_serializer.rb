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
#
# Indexes
#
#  index_replays_on_user_id  (user_id)
#

class ReplaySerializer < ApplicationSerializer
  set_type :replay
  attributes :id, :user_id, :version, :length, :map_name, :url, :recorded_at, :created_at
  has_many :players
  belongs_to :user

  def include
    [:players, :user]
  end
end
