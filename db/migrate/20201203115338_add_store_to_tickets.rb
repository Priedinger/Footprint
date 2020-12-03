class AddStoreToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :store, :string, default: "U Express"
  end
end
