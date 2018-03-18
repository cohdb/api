class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def as_json(options = {})
    {
      id: 1
    }
  end
end
