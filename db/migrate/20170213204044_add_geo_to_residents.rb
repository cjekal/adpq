class AddGeoToResidents < ActiveRecord::Migration[5.0]
  def change
    add_column :residents, :latitude, :decimal, precision: 15, scale: 10
    add_column :residents, :longitude, :decimal, precision: 15, scale: 10

    add_index :residents, [:latitude, :longitude]
  end
end
