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

ActiveRecord::Schema.define(version: 20140810074658) do

  create_table "alegeri_user_temas", force: true do |t|
    t.integer  "user_id"
    t.integer  "tema_id"
    t.string   "status_profesor"
    t.string   "status_student"
    t.integer  "sesiune_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alegeri_user_temas", ["sesiune_id"], name: "index_alegeri_user_temas_on_sesiune_id"
  add_index "alegeri_user_temas", ["tema_id"], name: "index_alegeri_user_temas_on_tema_id"
  add_index "alegeri_user_temas", ["user_id"], name: "index_alegeri_user_temas_on_user_id"

  create_table "capitols", force: true do |t|
    t.integer  "licenta_id"
    t.string   "nume"
    t.integer  "numar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "capitols", ["licenta_id"], name: "index_capitols_on_licenta_id"

  create_table "comentariu_capitols", force: true do |t|
    t.integer  "user_id"
    t.integer  "capitol_id"
    t.text     "continut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentariu_capitols", ["capitol_id"], name: "index_comentariu_capitols_on_capitol_id"
  add_index "comentariu_capitols", ["user_id"], name: "index_comentariu_capitols_on_user_id"

  create_table "comentariu_fisiers", force: true do |t|
    t.integer  "user_id"
    t.integer  "fisier_id"
    t.text     "continut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentariu_fisiers", ["fisier_id"], name: "index_comentariu_fisiers_on_fisier_id"
  add_index "comentariu_fisiers", ["user_id"], name: "index_comentariu_fisiers_on_user_id"

  create_table "comentariu_licentas", force: true do |t|
    t.integer  "user_id"
    t.integer  "licenta_id"
    t.text     "continut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentariu_licentas", ["licenta_id"], name: "index_comentariu_licentas_on_licenta_id"
  add_index "comentariu_licentas", ["user_id"], name: "index_comentariu_licentas_on_user_id"

  create_table "comentariu_temas", force: true do |t|
    t.integer  "user_id"
    t.integer  "tema_id"
    t.text     "continut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comentariu_temas", ["tema_id"], name: "index_comentariu_temas_on_tema_id"
  add_index "comentariu_temas", ["user_id"], name: "index_comentariu_temas_on_user_id"

  create_table "domenius", force: true do |t|
    t.string   "nume"
    t.text     "descriere"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domenius", ["user_id"], name: "index_domenius_on_user_id"

  create_table "fisiers", force: true do |t|
    t.string   "name"
    t.string   "path"
    t.date     "adaugat"
    t.integer  "user_id"
    t.integer  "capitol_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fisiers", ["capitol_id"], name: "index_fisiers_on_capitol_id"
  add_index "fisiers", ["user_id"], name: "index_fisiers_on_user_id"

  create_table "licenta_salvatas", force: true do |t|
    t.integer  "user_id"
    t.integer  "tema_id"
    t.integer  "sesiune_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "licenta_salvatas", ["sesiune_id"], name: "index_licenta_salvatas_on_sesiune_id"
  add_index "licenta_salvatas", ["tema_id"], name: "index_licenta_salvatas_on_tema_id"
  add_index "licenta_salvatas", ["user_id"], name: "index_licenta_salvatas_on_user_id"

  create_table "licentas", force: true do |t|
    t.integer  "user_id"
    t.integer  "tema_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "renuntat"
  end

  add_index "licentas", ["tema_id"], name: "index_licentas_on_tema_id"
  add_index "licentas", ["user_id"], name: "index_licentas_on_user_id"

  create_table "sesiunes", force: true do |t|
    t.date     "data_start"
    t.date     "data_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deadline"
  end

  create_table "temas", force: true do |t|
    t.string   "nume"
    t.text     "descriere"
    t.integer  "domeniu_id"
    t.boolean  "este_libera"
    t.integer  "user_id"
    t.integer  "sesiune_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "temas", ["domeniu_id"], name: "index_temas_on_domeniu_id"
  add_index "temas", ["sesiune_id"], name: "index_temas_on_sesiune_id"
  add_index "temas", ["user_id"], name: "index_temas_on_user_id"

  create_table "todos", force: true do |t|
    t.integer  "capitol_id"
    t.text     "continut"
    t.boolean  "este_gata"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "todos", ["capitol_id"], name: "index_todos_on_capitol_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "nume"
    t.string   "prenume"
    t.string   "rol"
    t.integer  "grupa"
    t.string   "grad"
    t.boolean  "este_eligibil_licenta"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "specializare"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["token"], name: "index_users_on_token"

end
