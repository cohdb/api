# frozen_string_literal: true
class ListRecordsFilteringStrategy < ApplicationStrategy
  def initialize(model_class, params)
    @model_class = model_class
    @params = params.slice(*permitted_attributes_for(model_class, :index))
  end

  def apply_to(scope)
    scope.where(@params)
  end
end
