class ChangeColumnToTrue < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :product_id, true
  end
end
