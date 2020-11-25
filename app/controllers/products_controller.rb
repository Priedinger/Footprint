class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @alternatives = Product.where(category_agribalyse: @product.category_agribalyse)
  end
end
