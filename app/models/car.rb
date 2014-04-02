class Car < ActiveRecord::Base
  attr_accessible :make, :model, :vin, :year, :miles, :description, :dealership_id, :transmission, :body_style, :exterior_color, :interior_color, :fuel, :engine, :doors, :wheel_base, :acquire_date, :acquire_price, :acquire_location, :smog_status, :smog_date, :smogged_by, :flooring, :flooring_company, :flooring_date, :license_plate
  belongs_to :dealership
  has_one :deal
  has_many :expenses
end

