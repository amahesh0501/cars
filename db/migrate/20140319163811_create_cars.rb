class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.belongs_to :dealership

      #vehicle_details
      t.string :make
      t.string :model
      t.string :vin
      t.integer :year
      t.string :miles
      t.string :status
      t.string :transmission
      t.string :body_style
      t.string :exterior_color
      t.string :interior_color
      t.string :fuel
      t.string :engine
      t.integer :doors
      t.string :wheel_base

      #purchase_information
      t.date :acquire_date
      t.integer :acquire_price
      t.string :acquire_location
      t.boolean :smog_status, default: false
      t.date :smog_date
      t.string :smogged_by
      t.boolean :flooring, default: false
      t.string :flooring_company
      t.date :flooring_date
      t.string :license_plate





      t.text :description

      t.timestamps
    end
  end
end

