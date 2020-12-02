class AddNutrigradeToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :nutriscore_grade, :string
  end
end
