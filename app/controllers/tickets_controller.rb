class TicketsController < ApplicationController

def show
  @ticket = Ticket.find(params[:id])
  authorize @ticket
end

end
