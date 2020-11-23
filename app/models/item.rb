class Item < ApplicationRecord
  belongs_to :product
  has_many :ticket_lines
end
