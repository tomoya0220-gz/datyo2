class AddAdultsAndChildrenToReservations < ActiveRecord::Migration[7.0]
  def change
    add_column :reservations, :adults, :integer
    add_column :reservations, :children, :integer
  end
end
