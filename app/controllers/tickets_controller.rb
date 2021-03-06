require "google/cloud/vision"
class TicketsController < ApplicationController

  def index
    @tickets = current_user.tickets.order(created_at: :desc)
    @title = "Historique"
  end

  def show
    @ticket = Ticket.find(params[:id])
    @title = "Ticket du #{l(@ticket.created_at, format: "%d %B %Y", locale: :fr)}"
    @unidentified_items = @ticket.items.where(product_id: nil)
    @identified_items = @ticket.items.where.not(product_id: nil).order(updated_at: :desc)
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
    text = read_ticket(tickets_params[:photo])
    if text == "no text in the photo"
      render :new
      return
    end

    # ticket "franprix v1"
    if text.include? 'franprix'
      p "**********************TICKET FRANPRIX *************************"
      p text = testfranprix(text)
    # ticket "u express v1"
    else
      p "************************ticket u express*************************"
      text = text.select {|item| item.length > 25}
    end

    @ticket.photo = text.join(",FOOTPRINT,")
    if @ticket.save
      items = @ticket.photo
      # items = []
      # items << @ticket.photo
      items.split(",FOOTPRINT,").each do |item|
      # items.each do |item|
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
    file = File.open('new_ticket.jpg',"wb") do |f|
      f.write(Base64.decode64(photo.split('data:image/png;base64,').last))
    end
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new(credentials: Rails.application.credentials.google_vision_apikey)
    response = image_annotator.document_text_detection image: Rails.root.join('new_ticket.jpg').to_path
    if response.responses.first.text_annotations.first.nil?
      return "no text in the photo"
    end
    text = response.responses.first.text_annotations.first.description.split("\n")
    p text
    # response.responses.each do |res|
      # text = res.text_annotations.first.description.split("\n")
        # res.text_annotations.each do |annotation|
        #   text << "#{annotation.description},"
        # end
    # end
    File.delete(Rails.root.join('new_ticket.jpg').to_path)
    # redirect_to new_ticket_path
    return text
  end

  def calculate_ticket_score(ticket)
    total_score = 0
    ticket.items.where.not(product_id: nil).each do |item|
      total_score += item.product.score
    end
    ticket_score = total_score / ticket.items.where.not(product_id: nil).count
  end

  def testfranprix(text)
    last_product_index = (text.index { |x| x.include?("€")} - 1)
    text = text[0..last_product_index]
    p text
    result= []
    text.reverse.each do |product|
      if !(product =~ /[a-z]/)
        result << product
      else
        break
      end
    end
    result
  end

end
