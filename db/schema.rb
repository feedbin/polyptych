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

ActiveRecord::Schema.define(:version => 20121106153545) do

  create_table "favicon_panels", :force => true do |t|
    t.integer  "favicon_id"
    t.integer  "panel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favicon_panels", ["favicon_id", "panel_id"], :name => "index_favicon_panels_on_favicon_id_and_panel_id", :unique => true
  add_index "favicon_panels", ["favicon_id"], :name => "index_favicon_panels_on_favicon_id"
  add_index "favicon_panels", ["panel_id"], :name => "index_favicon_panels_on_panel_id"

  create_table "favicons", :force => true do |t|
    t.string   "hostname"
    t.string   "content_type"
    t.text     "favicon"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "favicons", ["hostname"], :name => "index_favicons_on_hostname", :unique => true

  create_table "favicons_panels", :force => true do |t|
    t.integer  "favicon_id"
    t.integer  "panel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favicons_panels", ["favicon_id", "panel_id"], :name => "index_favicons_panels_on_favicon_id_and_panel_id", :unique => true
  add_index "favicons_panels", ["favicon_id"], :name => "index_favicons_panels_on_favicon_id"
  add_index "favicons_panels", ["panel_id"], :name => "index_favicons_panels_on_panel_id"

  create_table "panels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "panels", ["name"], :name => "index_panels_on_name", :unique => true

end
