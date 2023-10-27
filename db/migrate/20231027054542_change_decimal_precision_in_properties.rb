class ChangeDecimalPrecisionInProperties < ActiveRecord::Migration[6.0]
  def change
  	change_column :properties, :rent, :decimal, :precision => 10, :scale => 2
  	change_column :properties, :floor_size_in_ping, :decimal, :precision => 10, :scale => 2
  	change_column :properties, :floor_size_in_sqft, :decimal, :precision => 10, :scale => 2
  end
end
