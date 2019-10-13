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

ActiveRecord::Schema.define(version: 2019_10_13_133851) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "glnavies", force: :cascade do |t|
    t.string "keyid"
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.integer "range"
    t.string "freeword"
    t.integer "no_smoking"
    t.integer "card"
  end

  create_table "middles", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
    t.index ["post_id"], name: "index_middles_on_post_id"
    t.index ["tag_id"], name: "index_middles_on_tag_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "category_id"
    t.integer "user_id"
    t.text "comment"
    t.string "title"
    t.string "creator"
    t.string "publisher"
    t.string "publicname"
    t.string "volume"
    t.string "number"
    t.string "startingpage"
    t.string "endingpage"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "bookshelfname"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
