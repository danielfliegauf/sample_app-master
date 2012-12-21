class AddLatlngToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :latlng, :string
  end
end
