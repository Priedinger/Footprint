class TicketsController < ApplicationController

  def index
    @tickets = current_user.tickets
  end

  def show
    @ticket = Ticket.find(params[:id])
  end
  
  def new
    @ticket = Ticket.new
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to root_path, notice: "Votre ticket a été supprimé"
  end

private

  def items_params
    params.require(:ticket).permit(:photo, :user_id)
  end
end
