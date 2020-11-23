class Product < ApplicationRecord
  has_many :items
  has_many :favorites
end
