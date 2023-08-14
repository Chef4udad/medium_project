# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_13_134245) do
  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_posts", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_posts_on_list_id"
    t.index ["post_id"], name: "index_list_posts_on_post_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "lists_users", force: :cascade do |t|
    t.integer "list_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_lists_users_on_list_id"
    t.index ["user_id"], name: "index_lists_users_on_user_id"
  end

  create_table "post_revisions", force: :cascade do |t|
    t.integer "post_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "edited_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.index ["post_id"], name: "index_post_revisions_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "author"
    t.string "img"
    t.string "title", default: ""
    t.integer "no_of_likes", default: 0
    t.string "category", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft", default: false
    t.string "content"
  end

  create_table "posts_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fav_topic"
  end

  add_foreign_key "list_posts", "lists"
  add_foreign_key "list_posts", "posts"
  add_foreign_key "lists", "users"
  add_foreign_key "lists_users", "lists"
  add_foreign_key "lists_users", "users"
  add_foreign_key "post_revisions", "posts"
end
