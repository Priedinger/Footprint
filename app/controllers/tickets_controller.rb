class TicketsController < ApplicationController



  def index
    @tickets = current_user.tickets
  end
  
  def show
  @ticket = Ticket.find(params[:id])
  authorize @ticket
  end
  
  def new
    @ticket = Ticket.new
  end
end
