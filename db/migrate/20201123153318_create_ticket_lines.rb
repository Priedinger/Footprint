class CreateTicketLines < ActiveRecord::Migration[6.0]
  def change
    create_table :ticket_lines do |t|
      t.references :item, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
