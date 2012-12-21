class AddFbparamsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :uid, :integer, :limit => 8
  	add_column :users, :provider, :string
  	add_column :users, :oauth_token, :string
  	add_column :users, :oauth_expires_at, :string
  end
end
