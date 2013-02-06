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

ActiveRecord::Schema.define(:version => 20130206220414) do

  create_table "socialite_identities", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "socialite_users_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "socialite_identities", ["provider", "uid"], :name => "index_socialite_identities_on_provider_and_uid", :unique => true
  add_index "socialite_identities", ["socialite_users_id", "provider"], :name => "index_socialite_identities_on_socialite_users_id_and_provider", :unique => true
  add_index "socialite_identities", ["socialite_users_id"], :name => "index_socialite_identities_on_socialite_users_id"

  create_table "socialite_users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
