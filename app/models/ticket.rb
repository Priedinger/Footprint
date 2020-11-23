class Ticket < ApplicationRecord
  belongs_to :user
  has_many :ticket_lines
end
