class AddLevelToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :level, :string
  end
end
