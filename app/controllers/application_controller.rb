class ApplicationController < ActionController::API
  include Pundit

  def render(*args)
    options = args.extract_options!
    subject = options[:json]
    model = subject.is_a?(ActiveRecord::Relation) ? subject.model : subject.class
    serializer = "#{model.name}Serializer".constantize
    options[:json] = serializer.new(subject).serialized_json
    args << options
    super(*args)
  end

  private

  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
  end
end
