class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.date :day
      t.integer :hotel_id

      t.timestamps null: false
    end
  end
end
