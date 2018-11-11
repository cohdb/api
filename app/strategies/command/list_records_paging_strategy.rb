# frozen_string_literal: true
class Command::ListRecordsPagingStrategy < ListRecordsPagingStrategy
  def apply_to(scope)
    scope = scope.order(:tick, :id)
    scope = scope.where('(commands.tick, commands.id) > (?, ?)', cursor_params[:tick], cursor_params[:id]) if @params[:cursor].present?
    scope.limit(@params[:first])
  end

  protected

  def cursor_attributes
    %i[tick id]
  end
end
