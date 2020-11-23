class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.integer :score
      t.string :bar_code
      t.string :category
      t.string :name
      t.string :photo
      t.string :generic_name
      t.string :brand

      t.timestamps
    end
  end
end
