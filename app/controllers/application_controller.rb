class ApplicationController < ActionController::API
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def doorkeeper_unauthorized_render_options(error)
    { json: { error: error[:error].description } }
  end

  def render(*args)
    options = args.extract_options!
    subject = options[:json]

    unless subject.is_a?(Hash)
      model = subject.is_a?(ActiveRecord::Relation) ? subject.model : subject.class
      serializer = "#{model.name}Serializer".constantize
      options[:json] = serializer.new(subject).serialized_json
    end

    args << options
    super(*args)
  end

  private

  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
  end

  def not_authorized
    render json: { error: 'Access is forbidden' }, status: :forbidden
  end
end
