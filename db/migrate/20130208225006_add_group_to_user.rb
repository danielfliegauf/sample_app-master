class AddGroupToUser < ActiveRecord::Migration
  def change
    add_column :users, :group, :boolean
  end
end
