class AddEcogradeToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :ecoscore_grade, :string
  end
end
