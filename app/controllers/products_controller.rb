class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    if @product.name.match?(/&quot;/)
      #sentence.gsub! 'Robert', 'Joe'
      @title = @product.name.gsub! '&quot;', '"'
    else
      @title = @product.name
    end
    # création array alternatives : les produits ayant la même category agribalyse en excluant le produit de la show actuelle
    @alternatives = Product.where(category_agribalyse: @product.category_agribalyse).reject{|product| product.id == @product.id}
    @alternatives = @alternatives.select{|alternative| alternative.score >= @product.score}
  end
end
