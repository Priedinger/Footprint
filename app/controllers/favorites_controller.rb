class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user = current_user
    @product = Product.find(params[:product_id])
    @favorite.product = @product
    if @favorite.save
      redirect_to product_path(@product), notice: "Ajouté aux favoris"
    else
      render 'products/show'
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :product_id)
  end

end
