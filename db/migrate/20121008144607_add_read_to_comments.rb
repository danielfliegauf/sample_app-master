class AddReadToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :read, :boolean
  end
end
