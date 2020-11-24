class Ticket < ApplicationRecord
  belongs_to :user
  has_many :ticket_lines
  has_many :items, through: :ticket_lines
end
