class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to favorites_path
  end
end
