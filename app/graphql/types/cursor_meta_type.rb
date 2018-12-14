# frozen_string_literal: true
module Types
  class CursorMetaType < BaseObject
    field :cursor, ID, null: true
  end
end
