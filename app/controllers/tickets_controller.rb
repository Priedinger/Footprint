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

  def create
    # string séparées par des virgules ex: "papier toilette, hule d'olive, déodorant"
    @ticket = Ticket.new(tickets_params)
    @ticket.user = current_user
    @ticket.save
    items = params[:ticket][:photo]
    items.split(',').each do |item|
      # vérifier si l'item existe déjà
      if Item.where(description: item).where.not(product_id: nil).first
        # si cette description(item) est déjà associé à un produit dans la DB, on récupère l'item et on fait une ticket line avec
        item = Item.where(description: item).where.not(product_id: nil)
        TicketLine.create!(ticket_id: @ticket.id, item_id: item.first.id, quantity: 1)
      else
        # autrement on crée un nouvel item et une ticket line
        new_item = Item.create!(description: item)
        TicketLine.create(ticket_id: @ticket.id, item_id: new_item.id, quantity: 1)
      end
    end
    redirect_to ticket_items_path(@ticket)
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to tickets_path
  end

private

  def tickets_params
    params.require(:ticket).permit(:photo, :user_id)
  end
end
