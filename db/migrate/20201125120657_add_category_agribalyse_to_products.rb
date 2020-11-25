class AddCategoryAgribalyseToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :category_agribalyse, :integer
  end
end
