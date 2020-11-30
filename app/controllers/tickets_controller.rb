require "google/cloud/vision"
class TicketsController < ApplicationController

  def index
    @tickets = current_user.tickets
    @title = "Historique"
  end

  def show
    @ticket = Ticket.find(params[:id])
    @title = "Ticket n°#{@ticket.id}"
    @unidentified_items = @ticket.items.where(product_id: nil)
    authorize @ticket
  end

  def new
    @ticket = Ticket.new
    read_ticket
  end

  def read_ticket
    file_name ='https://media-cdn.tripadvisor.com/media/photo-s/14/60/a2/79/ticket-de-caisse.jpg'
    # res = Cloudinary::Uploader.upload(file_name) 
    # uploaded_url = res["url"]
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: JSON.parse(Rails.root.join("key.json").read))
    response = image_annotator.document_text_detection image: file_name
    text = ""
    response.responses.each do |res|
      res.text_annotations.each do |annotation|
        text << annotation.description
      end
    end
    puts text
    return text
  end

  def create
    # string séparées par des virgules ex: "papier toilette, hule d'olive, déodorant"
    @ticket = Ticket.new(tickets_params)
    @ticket.user = current_user
    if @ticket.save
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
        redirect_to ticket_path(@ticket)
    else
      render :new
    end
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
