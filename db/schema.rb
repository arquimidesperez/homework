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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.datetime "last_update", precision: 6, default: -> { "now()" }, null: false
    t.index ["last_name"], name: "idx_actors_last_name"
  end

  create_table "albums", id: :serial, force: :cascade do |t|
    t.string "title", limit: 160, null: false
    t.integer "artist_id", null: false
    t.index ["artist_id"], name: "ifk_album_artist_id"
  end

  create_table "artists", id: :serial, force: :cascade do |t|
    t.string "name", limit: 120
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 25, null: false
    t.datetime "last_update", precision: 6, default: -> { "now()" }, null: false
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 40, null: false
    t.string "last_name", limit: 20, null: false
    t.string "company", limit: 80
    t.string "address", limit: 70
    t.string "city", limit: 40
    t.string "state", limit: 40
    t.string "country", limit: 40
    t.string "postal_code", limit: 10
    t.string "phone", limit: 24
    t.string "fax", limit: 24
    t.string "email", limit: 60, null: false
    t.integer "support_rep_id"
    t.index ["support_rep_id"], name: "ifk_customer_support_rep_id"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.string "last_name", limit: 20, null: false
    t.string "first_name", limit: 20, null: false
    t.string "title", limit: 30
    t.integer "reports_to"
    t.datetime "birth_date"
    t.datetime "hire_date"
    t.string "address", limit: 70
    t.string "city", limit: 40
    t.string "state", limit: 40
    t.string "country", limit: 40
    t.string "postal_code", limit: 10
    t.string "phone", limit: 24
    t.string "fax", limit: 24
    t.string "email", limit: 60
    t.index ["reports_to"], name: "ifk_employee_reports_to"
  end

  create_table "film_actor", primary_key: ["actor_id", "film_id"], force: :cascade do |t|
    t.integer "actor_id", limit: 2, null: false
    t.integer "film_id", limit: 2, null: false
    t.datetime "last_update", precision: 6, default: -> { "now()" }, null: false
    t.index ["film_id"], name: "idx_fk_films_id"
  end

  create_table "film_category", id: false, force: :cascade do |t|
    t.integer "film_id", limit: 2, null: false
    t.integer "category_id", limit: 2, null: false
    t.datetime "last_update", precision: 6, default: -> { "now()" }, null: false
  end

  create_table "films", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.text "description"
    t.integer "release_year"
    t.integer "language_id", limit: 2, null: false
    t.integer "rental_duration", limit: 2, default: 3, null: false
    t.decimal "rental_rate", precision: 4, scale: 2, default: "4.99", null: false
    t.integer "length", limit: 2
    t.decimal "replacement_cost", precision: 5, scale: 2, default: "19.99", null: false
    t.text "rating", default: "G"
    t.datetime "last_update", precision: 6, default: -> { "now()" }, null: false
    t.text "special_features", array: true
    t.tsvector "fulltext", null: false
    t.index ["fulltext"], name: "films_fulltext_idx", using: :gist
    t.index ["language_id"], name: "idx_fk_language_id"
    t.index ["title"], name: "idx_title"
  end

  create_table "genres", id: :serial, force: :cascade do |t|
    t.string "name", limit: 120
  end

  create_table "invoice_lines", id: :serial, force: :cascade do |t|
    t.integer "invoice_id", null: false
    t.integer "track_id", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.integer "quantity", null: false
    t.index ["invoice_id"], name: "ifk_invoice_line_invoice_id"
    t.index ["track_id"], name: "ifk_invoice_line_track_id"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.integer "customer_id", null: false
    t.datetime "invoice_date", null: false
    t.string "billing_address", limit: 70
    t.string "billing_city", limit: 40
    t.string "billing_state", limit: 40
    t.string "billing_country", limit: 40
    t.string "billing_postal_code", limit: 10
    t.decimal "total", precision: 10, scale: 2, null: false
    t.index ["customer_id"], name: "ifk_invoice_customer_id"
  end

  create_table "media_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 120
  end

  create_table "playlist_track", primary_key: ["playlist_id", "track_id"], force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "track_id", null: false
    t.index ["track_id"], name: "ifk_playlist_track_track_id"
  end

  create_table "playlists", id: :serial, force: :cascade do |t|
    t.string "name", limit: 120
  end

  create_table "tracks", id: :serial, force: :cascade do |t|
    t.string "name", limit: 200, null: false
    t.integer "album_id"
    t.integer "media_type_id", null: false
    t.integer "genre_id"
    t.string "composer", limit: 220
    t.integer "milliseconds", null: false
    t.integer "bytes"
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.index ["album_id"], name: "ifk_track_album_id"
    t.index ["genre_id"], name: "ifk_track_genre_id"
    t.index ["media_type_id"], name: "ifk_track_media_type_id"
  end

  add_foreign_key "albums", "artists", name: "fk_album_artist_id"
  add_foreign_key "customers", "employees", column: "support_rep_id", name: "fk_customer_support_rep_id"
  add_foreign_key "employees", "employees", column: "reports_to", name: "fk_employee_reports_to"
  add_foreign_key "invoice_lines", "invoices", name: "fk_invoice_line_invoice_id"
  add_foreign_key "invoice_lines", "tracks", name: "fk_invoice_line_track_id"
  add_foreign_key "invoices", "customers", name: "fk_invoice_customer_id"
  add_foreign_key "playlist_track", "playlists", name: "fk_playlist_track_playlist_id"
  add_foreign_key "playlist_track", "tracks", name: "fk_playlist_track_track_id"
  add_foreign_key "tracks", "albums", name: "fk_track_album_id"
  add_foreign_key "tracks", "genres", name: "fk_track_genre_id"
  add_foreign_key "tracks", "media_types", name: "fk_track_media_type_id"
end
