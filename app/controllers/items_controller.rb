class ItemsController < ApplicationController

  def index
    @unidentified_items = Item.where(product_id: nil)
  end

end
