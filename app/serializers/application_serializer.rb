# frozen_string_literal: true
class ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  def initialize(subject)
    super(subject, include: include)
  end

  def include
    []
  end
end
