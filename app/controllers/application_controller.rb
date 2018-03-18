class ApplicationController < ActionController::API
  include Pundit

  def render(*args)
    options = args.extract_options!
    subject = options[:json]
    model = subject.model
    serializer = "#{model.name}Serializer".constantize
    options[:json] = serializer.new(subject).serialized_json
    args << options
    super(*args)
  end
end
