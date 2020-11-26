class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorites
    @title = 'Favoris'
  end

  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    @product = Product.find(params[:product])
    @favorite.product = @product
    if @favorite.save
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    if params[:redirect_to] == "index"
      redirect_to favorites_path
    else
      redirect_to product_path(@favorite.product_id)
    end
  end

  private

  # def favorite_params
  #   params.require(:favorite).permit(:user_id, :product_id)
  # end
end
