class TicketsController < ApplicationController

  def index
    @tickets = current_user.tickets
  end
  def new
    @ticket = Ticket.new
  end
end
