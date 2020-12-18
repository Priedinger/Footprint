class Item < ApplicationRecord
  belongs_to :product, optional: true
  has_many :ticket_lines, dependent: :destroy
end
