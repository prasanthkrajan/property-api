class CreateFavouriteProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :favourite_properties do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
