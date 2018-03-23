class ReplaySerializer < ApplicationSerializer
  set_type :replay
  attributes :id, :user_id, :version, :length, :map_name, :url, :recorded_at, :created_at
  has_many :players

  def include
    [:players]
  end
end
