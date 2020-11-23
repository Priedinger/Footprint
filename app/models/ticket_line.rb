class TicketLine < ApplicationRecord
  belongs_to :item
  belongs_to :ticket
end
