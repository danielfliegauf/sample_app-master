class CreateMindposts < ActiveRecord::Migration
  def change
  	create_table :mindposts do |t|
      t.references :micropost
      t.references :user

      t.timestamps
    end
    add_index :mindposts, :user_id
  end
end
