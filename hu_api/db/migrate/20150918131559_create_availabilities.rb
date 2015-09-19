class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.date :day
      t.references :hotel, index: true
      t.timestamps null: false
    end
  end
end
