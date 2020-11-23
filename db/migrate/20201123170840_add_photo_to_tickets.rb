class AddPhotoToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :photo, :string
  end
end
