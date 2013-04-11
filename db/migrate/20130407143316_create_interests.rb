class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :hobby
      t.string :homebase
      t.references :user

      t.timestamps
    end
    add_index :interests, :user_id
  end
end
