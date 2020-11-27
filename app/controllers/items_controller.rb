require 'json'
require 'open-uri'

class ItemsController < ApplicationController

  def index
    @ticket = Ticket.find(params[:ticket_id])
    authorize @ticket, :ticket_items?
  end

  def show
    @ticket = Ticket.find(params[:ticket_id])
    @unidentified_item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    # cette méthode récupère un code bar (params[:bar_code])
  end

  def update
    @item = Item.find(params[:id])
    @ticket = @item.ticket_lines.first.ticket_id

    # chercher un produit ayant le code bar en input
    @product_in_db = Product.find_by(bar_code: params[:bar_code])
    if @product_in_db
      @item.update(product_id: @product_in_db.id)

        redirect_to ticket_path(@ticket)
    else
      # call API open food fact avec le code bar
      url = "https://world.openfoodfacts.org/api/v0/product/#{params[:bar_code]}.json"
      product_serialized = open(url).read
      product = JSON.parse(product_serialized)
      # création d'un produit nouveau produit avec les infos de l'api
      # check si score ecoscore exist autrement 0 par défaut
      if product["status"] == 1 # 1 signifie que le bar_code correspond à un produit de l'API, 0 si n'existe pas
        if product["product"]["ecoscore_data"]
          score = product["product"]["ecoscore_data"]["score"]
        else
          score = 0
        end
        @new_product = Product.create(
          score: score,
          bar_code: params[:bar_code],
          category: product["product"]["categories_tags"].first,
          name: product["product"]["product_name_fr"],
          photo: product["product"]["selected_images"]["front"]["small"]["fr"],
          generic_name: product["product"]["generic_name"],
          brand: product["product"]["brands"],
          category_agribalyse: product["product"]["categories_properties"]["agribalyse_food_code:en"]
          )
        # attribution de l'id du nouveau produit à l'item
        @item.update(product_id: @new_product.id)
        redirect_to ticket_path(@ticket)
      else
        render :edit
      end
    end
    # @item.update(item_params)
  end

private

  def items_params
    params.require(:item).permit(:description, :product_id)
  end
end
