class Ticket < ApplicationRecord
  belongs_to :user
  has_many :ticket_lines, dependent: :destroy
  has_many :items, through: :ticket_lines
  validates :photo, presence: true
end
