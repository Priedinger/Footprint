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
    @identified_items = @ticket.items.where.not(product_id: nil)
    unless @ticket.items.where.not(product_id: nil).count == 0
      @ticket_score = calculate_ticket_score(@ticket)
    end
    authorize @ticket
  end

  def new
    @ticket = Ticket.new
    # read_ticket
  end

  def create
    # string séparées par des virgules ex: "papier toilette, hule d'olive, déodorant"
    @ticket = Ticket.new(tickets_params)
    @ticket.user = current_user
    @ticket.photo = read_ticket(tickets_params[:photo])
    if @ticket.save
      items = @ticket.photo
      items.split(" ").each do |item|
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

  def read_ticket(photo)
    api_key = {
    "type": "service_account",
    "project_id": "footprint-296817",
    "private_key_id": ENV["GOOGLE_APPLICATION_PRIVATE_KEY_ID"],
    "private_key": ENV["GOOGLE_APPLICATION_PRIVATE_KEY"].gsub("\\n","\n")[1..-3],
    "client_email": "footprint@footprint-296817.iam.gserviceaccount.com",
    "client_id": ENV["GOOGLE_APPLICATION_CLIENT_ID"],
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/footprint%40footprint-296817.iam.gserviceaccount.com"
  }

    file = File.open('new_ticket.jpg',"wb") do |f|
      f.write(Base64.decode64(photo.split('data:image/png;base64,').last))
    end

    # file_name ='https://media-cdn.tripadvisor.com/media/photo-s/14/60/a2/79/ticket-de-caisse.jpg'
    # res = Cloudinary::Uploader.upload(file_name)
    # uploaded_url = res["url"]
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: (api_key))
    response = image_annotator.document_text_detection image: Rails.root.join('new_ticket.jpg').to_path
    text = ""
    response.responses.each do |res|
      res.text_annotations.each do |annotation|
        text << annotation.description
      end
    end
    puts text
    return text
  end

  def calculate_ticket_score(ticket)
    total_score = 0
    ticket.items.where.not(product_id: nil).each do |item|
      total_score += item.product.score
    end
    ticket_score = total_score / ticket.items.where.not(product_id: nil).count
  end
end
