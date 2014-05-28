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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140528165322) do

  create_table "anecdotes", force: true do |t|
    t.string   "sujet"
    t.string   "theme"
    t.string   "texte"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "anecdotes", ["sujet", "user_id"], name: "index_anecdotes_on_sujet_and_user_id"

  create_table "personnes", force: true do |t|
    t.string   "nom"
    t.integer  "first_chap"
    t.string   "scene"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personnes", ["first_chap", "user_id"], name: "index_personnes_on_first_chap_and_user_id"

  create_table "scenes", force: true do |t|
    t.string   "lieu"
    t.string   "date"
    t.string   "recit"
    t.string   "personne"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenes", ["lieu", "user_id"], name: "index_scenes_on_lieu_and_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
