class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.belongs_to :dealership
      t.belongs_to :auction
      t.belongs_to :floorer
      t.belongs_to :card

      t.string :status

      #vehicle_details
      t.string :make
      t.string :model
      t.string :vin
      t.string :trim
      t.integer :year
      t.string :stock_number
      t.string :make_model_year
      t.string :miles
      t.string :transmission
      t.string :body_style
      t.string :exterior_color
      t.string :interior_color
      t.string :fuel
      t.string :engine
      t.integer :doors
      t.string :wheel_base
      t.string :license_plate


      #purchase_information
      t.date :acquire_date
      t.float :acquire_price
      t.string :acquire_location
      t.string :payment_method
      t.string :check_number
      t.string :invoice_number
      t.boolean :smog_status, default: false
      t.date :smog_date
      t.string :smogged_by
      t.float :smog_price, default: 0
      t.boolean :flooring, default: false
      t.string :flooring_company
      t.date :flooring_date
      t.float :reg_fees

      #more_information
      t.float :wholesale_price
      t.float :retail_price
      t.float :customer_price
      t.float :advertising_cost
      t.float :other_costs
      t.float :backend_pac
      t.float :frontend_pac

      t.attachment :image





      t.text :description

      t.timestamps
    end
  end
end

