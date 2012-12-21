class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :micropost
      t.references :user

      t.timestamps
    end
    add_index :comments, :micropost_id #TODO: Change into :micropost
  end
end
