# frozen_string_literal: true
class CommandPolicy < ApplicationPolicy
  def index?
    true
  end

  def permitted_attributes_for_index
    %i[player_id]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
