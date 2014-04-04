class Car < ActiveRecord::Base
  attr_accessible :make, :model, :vin, :year, :miles, :description, :dealership_id, :transmission, :body_style, :exterior_color, :interior_color, :fuel, :engine, :doors, :wheel_base, :acquire_date, :acquire_price, :acquire_location, :smog_status, :smog_date, :smogged_by, :flooring, :flooring_company, :flooring_date, :license_plate, :image, :status
  belongs_to :dealership
  has_one :deal
  has_many :expenses

  has_attached_file :image, styles: { medium: "320x240"}
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

end

