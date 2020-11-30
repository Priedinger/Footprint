class Ticket < ApplicationRecord
  # has_one_attached :photo
  belongs_to :user
  has_many :ticket_lines, dependent: :destroy
  has_many :items, through: :ticket_lines
end
