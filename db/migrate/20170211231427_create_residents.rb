class CreateResidents < ActiveRecord::Migration[5.0]
  def change
    create_table :residents do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :zip_code, null: false
      t.string :last_known_zip_code

      t.timestamps
    end
  end
end
