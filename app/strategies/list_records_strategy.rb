# frozen_string_literal: true
class ListRecordsStrategy < ApplicationStrategy
  include Pundit

  def initialize(model_class, params)
    @model_class = model_class
    @params = params.slice(*permitted_attributes)
  end

  def apply_to(scope)
    scope.where(@params)
  end

  protected

  def permitted_attributes
    policy = Pundit.policy(nil, @model_class)
    method_name = if policy.respond_to?('permitted_attributes_for_index')
                    'permitted_attributes_for_index'
                  else
                    'permitted_attributes'
                  end
    policy.public_send(method_name)
  end
end
