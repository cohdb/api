# frozen_string_literal: true
class ListRecordsPagingStrategy < ApplicationStrategy
  def initialize(params)
    raise ArgumentError 'params must contain first' unless params.key?(:first)
    @params = params.slice(:first, :cursor)
  end

  def apply_to(scope)
    scope = scope.where('id > ?', cursor_params[:id]) if @params[:cursor].present?
    scope.limit(@params[:first])
  end

  def cursor_for(scope)
    return if scope.count < @params[:first].to_i
    record = scope.last
    cursor_service.for_record(record)
  end

  protected

  def cursor_attributes
    %i[id]
  end

  private

  def cursor_service
    @cursor_service ||= CursorService.new(cursor_attributes)
  end

  def cursor_params
    cursor_service.to_params(@params[:cursor])
  end
end
