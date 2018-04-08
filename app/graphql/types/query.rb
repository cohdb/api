class Types::Query < Types::BaseObject
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :test_field, String, description: "An example field added by the generator", null: true

  def test_field
    "Hello World!"
  end

  field :replays, [Types::Replay], null: false

  def replays
    Replay.all.includes(:players).limit(2)
  end

  # field :replays, [Types::Replay], null: false do
  #   resolve ->(_, args, _) { Replay.all.includes(:players).limit(args[:limit] || 25) }
  # end

  # field :replay, Types::Replay, null: false do
  #   argument :id, ID, null: false
  #   resolve ->(_, args, _) { Replay.find(args[:id]) }
  # end
end
