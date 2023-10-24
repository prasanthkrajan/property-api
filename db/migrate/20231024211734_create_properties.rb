class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.decimal :rent, precision: 8, scale: 2
      t.string :currency
      t.string :full_address
      t.string :type
      t.integer :bedroom
      t.integer :bathroom
      t.string :closest_mrt
      t.decimal :floor_size_in_ping, precision: 8, scale: 2
      t.decimal :floor_size_in_sqft, precision: 8, scale: 2
      t.string :city
      t.string :district
      t.string :title
      t.text :image_url

      t.timestamps
    end
  end
end
