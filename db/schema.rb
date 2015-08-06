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

ActiveRecord::Schema.define(version: 20150806172759) do

  create_table "documents", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "json"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "original_text"
    t.string   "title"
    t.string   "source"
    t.string   "url"
    t.text     "words"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id"

  create_table "english_phrases", force: :cascade do |t|
    t.integer  "tokipona_phrase_id"
    t.string   "pos"
    t.text     "forms"
    t.string   "base_form"
    t.integer  "user_id"
    t.integer  "uses",               default: 0
    t.integer  "upvotes"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "english_phrases", ["base_form"], name: "index_english_phrases_on_base_form", unique: true
  add_index "english_phrases", ["tokipona_phrase_id"], name: "index_english_phrases_on_tokipona_phrase_id"
  add_index "english_phrases", ["user_id"], name: "index_english_phrases_on_user_id"

  create_table "proper_nouns", force: :cascade do |t|
    t.string   "form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "proper_nouns", ["form"], name: "index_proper_nouns_on_form", unique: true

  create_table "tokipona_phrases", force: :cascade do |t|
    t.text     "words"
    t.integer  "length"
    t.text     "full_form"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tokipona_phrases", ["words"], name: "index_tokipona_phrases_on_words", unique: true

  create_table "translation_segments", force: :cascade do |t|
    t.integer  "translation_id"
    t.integer  "place"
    t.integer  "english_phrase_id"
    t.string   "english_form"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "translation_segments", ["english_phrase_id"], name: "index_translation_segments_on_english_phrase_id"
  add_index "translation_segments", ["place"], name: "index_translation_segments_on_place"
  add_index "translation_segments", ["translation_id"], name: "index_translation_segments_on_translation_id"

  create_table "translations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.text     "translation_segments"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "translations", ["document_id"], name: "index_translations_on_document_id"
  add_index "translations", ["user_id"], name: "index_translations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
