class CreateInvitations < ActiveRecord::Migration
  def up
  	create_table :invitations do |t|
	    t.integer :inviter_id, :limit => 8
	    t.integer :invited_id, :limit => 8
	    t.integer :status, :limit => 1
	    t.references :micropost

	    t.timestamps
	end

	add_index :invitations, :inviter_id
    add_index :invitations, :invited_id
    add_index :invitations, :micropost
    add_index :invitations, [:inviter_id, :invited_id, :micropost], unique: true
  end

  def down
  	drop_table :invitations
  	remove_index :invitations, :inviter_id
    remove_index :invitations, :invited_id
    remove_index :invitations, :micropost
    remove_index :invitations, [:inviter_id, :invited_id, :micropost], unique: true
  end
end
