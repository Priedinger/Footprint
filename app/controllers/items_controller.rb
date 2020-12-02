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
    @title = "Scan de '#{@item.description}'"
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
          category: clean_category(product["product"]["categories_tags"]),
          name: product["product"]["product_name_fr"],
          photo: product["product"]["selected_images"]["front"]["small"].first[1],
          generic_name: product["product"]["generic_name"],
          brand: product["product"]["brands"],
          category_agribalyse: product["product"]["categories_properties"]["agribalyse_food_code:en"],
          ecoscore_grade: product["product"]["ecoscore_grade"],
          nutriscore_grade: product["product"]["nutriscore_grade"]
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

  def clean_category(off_category)
    if off_category.include?("en:meats") || off_category.include?("en:seafood")
      return "Viandes et poissons"
    elsif off_category.include?("en:fresh-vegetables") || off_category.include?("en:fruits")
      return "Fruits et légumes"
    elsif off_category.include?("en:non-food-products")
      return "Produits non alimentaires"
    elsif off_category.include?("en:boissons") || off_category.include?("en:beverages")
      return "Boissons"
    elsif off_category.include?("en:dairies")
      return "Produits laitiers"
    elsif off_category.include?("en:snacks")
      return "Snacks"
    elsif off_category.include?("en:viennoiseries") || off_category.include?("en:breads")
      return "Pains et patisseries"
    elsif off_category.include?("en:frozen-foods")
      return "Surgelés"
    elsif off_category.include?("en:desserts")
      return "Desserts"
    elsif off_category.include?("en:plant-based-foods-and-beverages")
      return "Produits d'origine végétale"
    else
      return "Autres"
    end
  end

end
