# frozen_string_literal: true
class ApplicationStrategy
  include Pundit

  def apply_to
    raise NotImplementedError
  end

  protected

  def permitted_attributes_for(model_class, action)
    policy = Pundit.policy(nil, model_class)
    method_name = if policy.respond_to?("permitted_attributes_for_#{action}")
                    "permitted_attributes_for_#{action}"
                  else
                    'permitted_attributes'
                  end
    policy.public_send(method_name)
  end
end
