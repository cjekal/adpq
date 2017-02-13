class AddFieldsToResidents < ActiveRecord::Migration[5.0]
  def change
    add_column :residents, :subscription_endpoint, :string
    add_column :residents, :subscription_keys_p256dh, :string
    add_column :residents, :subscription_keys_auth, :string
  end
end
