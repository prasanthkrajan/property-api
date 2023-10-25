class ChangeTypeColumnToPropertyType < ActiveRecord::Migration[6.0]
  def change
  	rename_column :properties, :type, :unit_type
  end
end
