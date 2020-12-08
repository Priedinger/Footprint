class FavoritesController < ApplicationController

  def index
    if params[:query].present?
      sql_query = " \
      products.name ILIKE :query \
      OR products.generic_name ILIKE :query \
      OR products.brand ILIKE :query \
      "
      @favorites = current_user.favorites.joins(:product).where(sql_query, query: "%#{params[:query]}%")
      
    else
      @favorites = current_user.favorites.order(created_at: :desc)
    end
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
