# frozen_string_literal: true
module Types::ObjectListInterface
  include Types::BaseInterface

  field :meta, Types::CursorMetaType, null: false
end
