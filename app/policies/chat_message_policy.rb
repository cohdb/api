# frozen_string_literal: true
class ChatMessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
