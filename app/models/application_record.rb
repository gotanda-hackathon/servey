class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def permit_params
      column_names + [
          :_destroy
      ]
    end
  end
end
