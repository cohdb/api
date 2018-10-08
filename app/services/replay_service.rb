# frozen_string_literal: true
class ReplayService
  def initialize(file)
    @file = file
  end

  def to_json
    Vault.parse(@file.path) do |ptr|
      JSON.parse(ptr.read_string)
    end
  end
end
