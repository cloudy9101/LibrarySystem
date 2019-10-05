class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :book
      t.string :username

      t.timestamps
    end
  end
end
