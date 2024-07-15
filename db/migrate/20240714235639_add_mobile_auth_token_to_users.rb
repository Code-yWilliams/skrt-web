class AddMobileAuthTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mobile_auth_token, :string
  end
end
