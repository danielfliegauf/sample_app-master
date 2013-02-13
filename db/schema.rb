# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130208225006) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "micropost_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "read"
  end

  add_index "comments", ["micropost_id"], :name => "index_comments_on_micropost_id"

  create_table "invitations", :force => true do |t|
    t.integer  "inviter_id", :limit => 8
    t.integer  "invited_id", :limit => 8
    t.integer  "status",     :limit => 1
    t.integer  "micropost"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "invitations", ["invited_id"], :name => "index_invitations_on_invited_id"
  add_index "invitations", ["inviter_id", "invited_id"], :name => "index_invitations_on_inviter_id_and_invited_id", :unique => true
  add_index "invitations", ["inviter_id"], :name => "index_invitations_on_inviter_id"
  add_index "invitations", ["micropost"], :name => "index_invitations_on_micropost"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id",    :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "hobby"
    t.string   "place"
    t.string   "country"
    t.datetime "datetime"
    t.boolean  "weekly"
    t.string   "weekday"
    t.string   "status"
    t.string   "latlng"
    t.string   "level"
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "mindposts", :force => true do |t|
    t.integer  "micropost_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "mindposts", ["user_id"], :name => "index_mindposts_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id", :limit => 8
    t.integer  "followed_id", :limit => 8
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                         :default => false
    t.integer  "uid",              :limit => 8
    t.string   "provider"
    t.string   "oauth_token"
    t.string   "oauth_expires_at"
    t.string   "last_active"
    t.boolean  "group"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
