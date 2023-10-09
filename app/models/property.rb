class Property < ApplicationRecord
    has_one :favorite_list
  
    # your other code...
  
    def favourite?
      self.favorite_list.present?
    end
  
    def as_json(options = {})
      super(options).merge({
        favourite: self.favourite?
      })
    end
end
