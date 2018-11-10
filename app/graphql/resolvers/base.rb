# frozen_string_literal: true
class Resolvers::Base < GraphQL::Schema::Resolver
  include Pundit

  %i[current_user].each do |attribute|
    define_method(attribute) { context[attribute] }
  end

  def authorize(record, query)
    Pundit.authorize(current_user, record, query)
  end

  def policy_scope(scope)
    Pundit.policy_scope(current_user, scope)
  end

  def self.permitted_attributes_for(record, action)
    policy = Pundit.policy(nil, record)
    method_name = if policy.respond_to?("permitted_attributes_for_#{action}")
                    "permitted_attributes_for_#{action}"
                  else
                    'permitted_attributes'
                  end
    policy.public_send(method_name)
  end
end
