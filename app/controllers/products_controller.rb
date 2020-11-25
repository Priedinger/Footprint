class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    # création array alternatives : les produits ayant la même category agribalyse en excluant le produit de la show actuelle
    @alternatives = Product.where(category_agribalyse: @product.category_agribalyse).reject{|product| product.id == @product.id}
  end
end
