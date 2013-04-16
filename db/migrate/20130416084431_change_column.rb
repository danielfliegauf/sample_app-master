class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :microposts, :content, :text, :limit => nil
  end

  def down
    change_column :microposts, :content, :string
  end
end
