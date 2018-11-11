# frozen_string_literal: true
module Types
  class CommandListType < BaseObjectList
    field :records, [CommandType], null: false
  end
end
