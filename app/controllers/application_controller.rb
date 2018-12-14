# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def doorkeeper_unauthorized_render_options(error)
    response = [
      {
        code: :invalid_token,
        title: 'Unauthorized',
        detail: error[:error].description
      }
    ]

    { json: { errors: response } }
  end

  # def render(*args)
  #   options = args.extract_options!
  #   subject = options[:json]
  #
  #   unless subject.is_a?(Hash) || subject.is_a?(Array)
  #     model = subject.is_a?(ActiveRecord::Relation) ? subject.model : subject.class
  #     serializer = "#{model.name}Serializer".constantize
  #     options[:json] = serializer.new(subject).serialized_json
  #   end
  #
  #   args << options
  #   super(*args)
  # end

  private

  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
  end

  def not_authorized
    response = [
      {
        code: :insufficient_permissions,
        title: 'Forbidden',
        detail: 'You cannot access this particular resource'
      }
    ]

    render json: { errors: response }, status: :forbidden
  end

  def not_found(exception)
    response = [
      {
        code: :not_found,
        title: 'Not Found',
        detail: exception.message
      }
    ]

    render json: { errors: response }, status: :not_found
  end
end
