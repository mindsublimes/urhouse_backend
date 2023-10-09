class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.integer :price_per_month
      t.text :address
      t.integer :number_of_rooms
      t.string :mrt
      
      t.timestamps
    end
  end
end
