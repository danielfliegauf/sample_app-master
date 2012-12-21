class AddHobbyPlaceToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :hobby, :string
  	add_column :microposts, :place, :string
  	add_column :microposts, :country, :string
  end
end
