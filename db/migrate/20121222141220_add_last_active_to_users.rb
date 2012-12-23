class AddLastActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_active, :string
  end
end
