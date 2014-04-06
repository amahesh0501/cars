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

ActiveRecord::Schema.define(version: 20140404231925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: true do |t|
    t.integer  "dealership_id"
    t.string   "status"
    t.string   "make"
    t.string   "model"
    t.string   "vin"
    t.integer  "year"
    t.string   "make_model_year"
    t.string   "miles"
    t.string   "transmission"
    t.string   "body_style"
    t.string   "exterior_color"
    t.string   "interior_color"
    t.string   "fuel"
    t.string   "engine"
    t.integer  "doors"
    t.string   "wheel_base"
    t.string   "license_plate"
    t.date     "acquire_date"
    t.integer  "acquire_price"
    t.string   "acquire_location"
    t.boolean  "smog_status",        default: false
    t.date     "smog_date"
    t.string   "smogged_by"
    t.boolean  "flooring",           default: false
    t.string   "flooring_company"
    t.date     "flooring_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "conversations", force: true do |t|
    t.integer  "dealership_id"
    t.integer  "employee_id"
    t.integer  "customer_id"
    t.date     "date"
    t.text     "description"
    t.string   "medium"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address"
    t.string   "time_at_residence"
    t.string   "phone"
    t.string   "email"
    t.date     "dob"
    t.string   "ssn"
    t.text     "notes"
    t.string   "driver_license_number"
    t.string   "employer"
    t.string   "employer_contact"
    t.string   "employer_title"
    t.string   "employer_address"
    t.string   "employer_phone"
    t.integer  "monthly_gross_salary"
    t.integer  "time_at_employer"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "dealerships", force: true do |t|
    t.string   "dealership_name"
    t.string   "dealership_address"
    t.string   "access_code",        default: "12345"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", force: true do |t|
    t.integer  "car_id"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "dealership_id"
    t.date     "date"
    t.integer  "purchase_price"
    t.integer  "sales_tax_amount"
    t.integer  "down_payment"
    t.integer  "term"
    t.integer  "apr"
    t.integer  "trade_in_value"
    t.boolean  "gap_insurance",    default: false
    t.string   "gap_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "email"
    t.string   "ssn"
    t.string   "address"
    t.string   "phone"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: true do |t|
    t.integer  "dealership_id"
    t.integer  "vendor_id"
    t.string   "name"
    t.integer  "amount"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "dealership_id"
    t.boolean  "revoked",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paychecks", force: true do |t|
    t.integer  "employee_id"
    t.integer  "dealership_id"
    t.integer  "amount"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repairs", force: true do |t|
    t.integer  "car_id"
    t.integer  "dealership_id"
    t.integer  "vendor_id"
    t.string   "name"
    t.integer  "amount"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "user_type",              default: "employee"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vendors", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
