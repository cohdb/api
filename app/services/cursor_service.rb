# frozen_string_literal: true
class CursorService
  def initialize(attributes)
    @attributes = attributes.map(&:to_s)
  end

  def to_params(cursor)
    Base64.urlsafe_decode64(cursor).split('&').map do |pair|
      [pair.split('=').first, pair.split('=').last]
    end.to_h.slice(*@attributes).transform_keys(&:to_sym)
  end

  def for_record(record)
    return if record.nil?
    query_string = record.attributes.slice(*@attributes).map do |key, value|
      "#{key}=#{value}"
    end.join('&')
    Base64.urlsafe_encode64(query_string)
  end
end
