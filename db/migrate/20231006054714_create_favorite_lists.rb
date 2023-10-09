class CreateFavoriteLists < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_lists do |t|
      t.references :user
      t.references :property
      t.timestamps
    end
  end
end
