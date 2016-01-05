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

ActiveRecord::Schema.define(version: 20160105100506) do

  create_table "booklists", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "booklists", ["user_id", "created_at"], name: "index_booklists_on_user_id_and_created_at"

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "author"
    t.string   "cover"
    t.string   "source"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follow_booklists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "booklist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follow_booklists", ["booklist_id"], name: "index_follow_booklists_on_booklist_id"
  add_index "follow_booklists", ["user_id", "booklist_id"], name: "index_follow_booklists_on_user_id_and_booklist_id", unique: true
  add_index "follow_booklists", ["user_id"], name: "index_follow_booklists_on_user_id"

  create_table "follow_users", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follow_users", ["followed_id"], name: "index_follow_users_on_followed_id"
  add_index "follow_users", ["follower_id", "followed_id"], name: "index_follow_users_on_follower_id_and_followed_id", unique: true
  add_index "follow_users", ["follower_id"], name: "index_follow_users_on_follower_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["book_id"], name: "index_ratings_on_book_id"
  add_index "ratings", ["user_id", "book_id"], name: "index_ratings_on_user_id_and_book_id", unique: true
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "shelf_books", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shelf_books", ["book_id"], name: "index_shelf_books_on_book_id"
  add_index "shelf_books", ["user_id", "book_id"], name: "index_shelf_books_on_user_id_and_book_id", unique: true
  add_index "shelf_books", ["user_id"], name: "index_shelf_books_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
