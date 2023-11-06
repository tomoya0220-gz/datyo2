class RemoveForeignKeyFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :reservations, column: :user_id
  end
end
