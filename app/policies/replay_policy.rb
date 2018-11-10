# frozen_string_literal: true
class ReplayPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    record.user_id == user&.id
  end

  def permitted_attributes_for_create
    %i[user_id rec]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
