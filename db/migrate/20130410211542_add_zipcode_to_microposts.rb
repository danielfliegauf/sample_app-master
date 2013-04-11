class AddZipcodeToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :zipcode, :integer
    add_index :microposts, [:place, :user_id]
  end
end
