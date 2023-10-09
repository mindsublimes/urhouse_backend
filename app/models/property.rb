class Property < ApplicationRecord

  has_many :favorite_lists
  has_many :users, through: :favorite_lists
end
