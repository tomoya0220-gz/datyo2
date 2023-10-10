class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :date
      t.string :time_slot
      t.integer :number_of_people
      t.text :note
      
      t.timestamps
    end
  end
end
