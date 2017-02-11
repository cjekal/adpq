class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :category, null: false
      t.string :unique_identifier, null: false
      t.string :zip_code
      t.string :additional_info_url

      t.timestamps
    end
  end
end
