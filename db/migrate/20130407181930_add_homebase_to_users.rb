class AddHomebaseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :homebase, :string
  end
end
