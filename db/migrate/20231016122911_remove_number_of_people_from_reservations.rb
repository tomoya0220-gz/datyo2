class RemoveNumberOfPeopleFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :number_of_people, :integer
  end
end
