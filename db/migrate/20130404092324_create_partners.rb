class CreatePartners < ActiveRecord::Migration
  def up
    create_table :partners do |t|
      t.string :name
      t.string :url
      t.integer :status
      t.string :email
      t.string :street
      t.string :city
      t.integer :phone
      t.string :password
      t.string :password_digest
      t.string :remember_token
      t.references :ad

      t.timestamps
    end

    add_index :partners, :email, unique: true
    add_index :partners, :name, unique: true
    add_index :partners, :remember_token
  end

  def down
    drop_table :partners
  end
end
