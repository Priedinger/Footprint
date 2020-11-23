class ItemsController < ApplicationController
  def show
    @unidentified_item = Item.find(params[:id])
  end
end
