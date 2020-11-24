class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    @product = Product.find(params[:product])
    @favorite.product = @product
    if @favorite.save
      redirect_to product_path(@product), notice: "Ajouté aux favoris"
    else
      render 'products/show', notice: "Une erreur est survenue"
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to product_path(@favorite.product_id), notice: "Supprimé des favoris"
  end

  private

  # def favorite_params
  #   params.require(:favorite).permit(:user_id, :product_id)
  # end
end
