class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :city_id
      t.string :integer

      t.timestamps null: false
    end
  end
end
