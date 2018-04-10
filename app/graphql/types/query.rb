class Types::Query < Types::BaseObject

  field :replays, [Types::Replay], null: false do
    argument :limit, Int, required: false, default_value: 25
  end

  def replays(limit:)
    ::Replay.all.includes(:players).limit(limit)
  end

  field :replay, Types::Replay, null: false do
    argument :id, ID, required: true
  end

  def replay(id:)
    ::Replay.find(id)
  end
end
