class ItemsController < ApplicationController

  def update
    @item = Conveying.find(params[:id])
    @item.update(item_params)
  end

private

  def items_params
    params.require(:item).permit(:description, :product_id)
  end
end
