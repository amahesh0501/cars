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

ActiveRecord::Schema.define(version: 20140627003105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "email"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", force: true do |t|
    t.integer  "dealership_id"
    t.integer  "auction_id"
    t.integer  "floorer_id"
    t.integer  "card_id"
    t.string   "status"
    t.string   "make"
    t.string   "model"
    t.string   "vin"
    t.string   "trim"
    t.integer  "year"
    t.string   "stock_number"
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
    t.float    "acquire_price"
    t.string   "acquire_location"
    t.string   "payment_method"
    t.string   "check_number"
    t.string   "invoice_number"
    t.boolean  "smog_status",        default: false
    t.date     "smog_date"
    t.string   "smogged_by"
    t.float    "smog_price"
    t.boolean  "flooring",           default: false
    t.string   "flooring_company"
    t.date     "flooring_date"
    t.float    "reg_fees"
    t.float    "wholesale_price"
    t.float    "retail_price"
    t.float    "customer_price"
    t.float    "advertising_cost"
    t.float    "other_costs"
    t.float    "backend_pac"
    t.float    "frontend_pac"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions", force: true do |t|
    t.integer "car_id"
    t.integer "dealership_id"
    t.integer "employee_id"
    t.date    "date"
    t.float   "amount"
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
    t.float    "monthly_gross_salary"
    t.integer  "time_at_employer"
    t.string   "status",                     default: "Potential Customer"
    t.string   "first"
    t.string   "last"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "employer_address_line_1"
    t.string   "employer_address_line_2"
    t.string   "employer_address_city"
    t.string   "employer_address_state"
    t.string   "employer_address_zip"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "license_photo_file_name"
    t.string   "license_photo_content_type"
    t.integer  "license_photo_file_size"
    t.datetime "license_photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dealerships", force: true do |t|
    t.string   "dealership_name"
    t.string   "dealership_address"
    t.string   "access_code",        default: "12345"
    t.float    "sales_tax",          default: 6.0
    t.boolean  "active",             default: true
    t.float    "start_balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deals", force: true do |t|
    t.integer  "car_id"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "dealership_id"
    t.integer  "warranty_id"
    t.integer  "gap_id"
    t.integer  "lender_id"
    t.date     "date"
    t.float    "amount",                  default: 0.0
    t.float    "sales_tax_amount",        default: 0.0
    t.float    "sales_tax_percent",       default: 0.0
    t.float    "down_payment",            default: 0.0
    t.integer  "term",                    default: 1
    t.integer  "apr",                     default: 0
    t.float    "commission",              default: 0.0
    t.float    "trade_in_value",          default: 0.0
    t.float    "less_payoff",             default: 0.0
    t.float    "deffered_down_1_payment", default: 0.0
    t.date     "deffered_down_1_date"
    t.float    "deffered_down_2_payment", default: 0.0
    t.date     "deffered_down_2_date"
    t.float    "deffered_down_3_payment", default: 0.0
    t.date     "deffered_down_3_date"
    t.float    "smog_fee",                default: 0.0
    t.float    "other_fee",               default: 0.0
    t.float    "doc_fee",                 default: 0.0
    t.float    "reg_fee",                 default: 0.0
    t.float    "warranty_term",           default: 0.0
    t.float    "warranty_price",          default: 0.0
    t.float    "warranty_cost",           default: 0.0
    t.string   "warranty_type"
    t.float    "gap_term",                default: 0.0
    t.float    "gap_price",               default: 0.0
    t.float    "gap_cost",                default: 0.0
    t.float    "accessory_price",         default: 0.0
    t.float    "accessory_cost",          default: 0.0
    t.float    "discount_fee",            default: 0.0
    t.date     "first_payment_date"
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
    t.text     "description"
    t.string   "first"
    t.string   "last"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.integer  "number"
    t.date     "birthday"
    t.date     "hire_date"
    t.date     "terminate_date"
    t.string   "title"
    t.string   "driver_license_number"
    t.string   "sales_license"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "license_photo_file_name"
    t.string   "license_photo_content_type"
    t.integer  "license_photo_file_size"
    t.datetime "license_photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: true do |t|
    t.integer  "dealership_id"
    t.integer  "vendor_id"
    t.integer  "partner_id"
    t.integer  "card_id"
    t.string   "name"
    t.float    "amount"
    t.text     "description"
    t.date     "date"
    t.string   "payment_method"
    t.string   "check_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "floorers", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "email"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.text     "description"
    t.string   "form_pdf_file_name"
    t.string   "form_pdf_content_type"
    t.integer  "form_pdf_file_size"
    t.datetime "form_pdf_updated_at"
  end

  create_table "gaps", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lenders", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "dealership_id"
    t.string   "email_address"
    t.boolean  "has_access",          default: false
    t.boolean  "is_dealership_admin", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.integer "dealership_id"
    t.string  "name"
    t.string  "basic_one_title"
    t.text    "basic_one_description"
    t.float   "basic_one_amount"
    t.string  "basic_two_title"
    t.text    "basic_two_description"
    t.float   "basic_two_amount"
    t.string  "basic_three_title"
    t.text    "basic_three_description"
    t.float   "basic_three_amount"
    t.string  "basic_four_title"
    t.text    "basic_four_description"
    t.float   "basic_four_amount"
    t.string  "basic_five_title"
    t.text    "basic_five_description"
    t.float   "basic_five_amount"
    t.string  "standard_one_title"
    t.text    "standard_one_description"
    t.float   "standard_one_amount"
    t.string  "standard_two_title"
    t.text    "standard_two_description"
    t.float   "standard_two_amount"
    t.string  "standard_three_title"
    t.text    "standard_three_description"
    t.float   "standard_three_amount"
    t.string  "standard_four_title"
    t.text    "standard_four_description"
    t.float   "standard_four_amount"
    t.string  "standard_five_title"
    t.text    "standard_five_description"
    t.float   "standard_five_amount"
    t.string  "good_one_title"
    t.text    "good_one_description"
    t.float   "good_one_amount"
    t.string  "good_two_title"
    t.text    "good_two_description"
    t.float   "good_two_amount"
    t.string  "good_three_title"
    t.text    "good_three_description"
    t.float   "good_three_amount"
    t.string  "good_four_title"
    t.text    "good_four_description"
    t.float   "good_four_amount"
    t.string  "good_five_title"
    t.text    "good_five_description"
    t.float   "good_five_amount"
    t.string  "best_one_title"
    t.text    "best_one_description"
    t.float   "best_one_amount"
    t.string  "best_two_title"
    t.text    "best_two_description"
    t.float   "best_two_amount"
    t.string  "best_three_title"
    t.text    "best_three_description"
    t.float   "best_three_amount"
    t.string  "best_four_title"
    t.text    "best_four_description"
    t.float   "best_four_amount"
    t.string  "best_five_title"
    t.text    "best_five_description"
    t.float   "best_five_amount"
  end

  create_table "partners", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paychecks", force: true do |t|
    t.integer  "employee_id"
    t.integer  "dealership_id"
    t.integer  "card_id"
    t.string   "name"
    t.float    "amount"
    t.text     "description"
    t.date     "date"
    t.string   "payment_method"
    t.string   "check_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "dealership_id"
    t.integer  "card_id"
    t.date     "date"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", force: true do |t|
    t.integer  "car_id"
    t.integer  "dealership_id"
    t.integer  "card_id"
    t.string   "name"
    t.float    "amount"
    t.date     "date"
    t.string   "location"
    t.string   "payment_method"
    t.string   "check_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repairs", force: true do |t|
    t.integer  "car_id"
    t.integer  "dealership_id"
    t.integer  "vendor_id"
    t.integer  "card_id"
    t.integer  "gap_id"
    t.integer  "warranty_id"
    t.integer  "lender_id"
    t.string   "name"
    t.float    "amount"
    t.text     "description"
    t.date     "date"
    t.string   "payment_method"
    t.string   "check_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revenues", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.float    "amount"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "temps", force: true do |t|
    t.integer  "car_id"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.integer  "dealership_id"
    t.integer  "warranty_id"
    t.integer  "gap_id"
    t.integer  "lender_id"
    t.date     "date"
    t.float    "amount"
    t.float    "sales_tax_amount"
    t.float    "sales_tax_percent"
    t.float    "down_payment"
    t.integer  "term"
    t.integer  "apr"
    t.float    "trade_in_value"
    t.float    "less_payoff"
    t.float    "days_to_first_payment"
    t.float    "deffered_down_1_payment"
    t.date     "deffered_down_1_date"
    t.float    "deffered_down_2_payment"
    t.date     "deffered_down_2_date"
    t.float    "deffered_down_3_payment"
    t.date     "deffered_down_3_date"
    t.float    "smog_fee"
    t.float    "other_fee"
    t.float    "doc_fee"
    t.float    "reg_fee"
    t.float    "warranty_term"
    t.float    "warranty_price"
    t.float    "warranty_cost"
    t.string   "warranty_type"
    t.float    "gap_term"
    t.float    "gap_price"
    t.float    "gap_cost"
    t.float    "accessory_price"
    t.float    "accessory_cost"
    t.float    "discount_fee"
    t.float    "estimated_commission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "site_admin",             default: false
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
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warranties", force: true do |t|
    t.integer  "dealership_id"
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
