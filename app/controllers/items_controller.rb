class ItemsController < ApplicationController
 
  def index
    @unidentified_items = Item.where(product_id: nil)
  end
  
   def show
    @unidentified_item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
  end

private

  def items_params
    params.require(:item).permit(:description, :product_id)
  end
end
