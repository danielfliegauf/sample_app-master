class AddTimevarsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :datetime, :datetime
    add_column :microposts, :weekly, :boolean
    add_column :microposts, :weekday, :string
  end
end
