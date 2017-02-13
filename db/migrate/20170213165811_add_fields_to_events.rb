class AddFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :endpoint, :string
    add_column :events, :layer, :integer
    add_column :events, :latitude, :decimal, precision: 15, scale: 10
    add_column :events, :longitude, :decimal, precision: 15, scale: 10

    add_index :events, [:latitude, :longitude]
  end
end
