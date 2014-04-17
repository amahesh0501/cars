class Car < ActiveRecord::Base
  attr_accessible :make, :model, :vin, :year, :miles, :description, :dealership_id, :transmission, :body_style, :exterior_color, :interior_color, :fuel, :engine, :doors, :wheel_base, :acquire_date, :acquire_price, :acquire_location, :smog_status, :smog_date, :smogged_by, :flooring, :flooring_company, :flooring_date, :license_plate, :image, :status, :trim

  belongs_to :dealership
  has_one :deal
  has_many :repairs, dependent: :destroy
  has_one :purchase, dependent: :destroy

  validates_presence_of :make, :model, :year, :acquire_price, :acquire_date, :dealership_id, :status

  has_attached_file :image, styles: { small: "115x115", medium: "320x240"}, default_url: "/car.png"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def acquire_price=(num)
    self[:acquire_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def vin_lookup(vin)
    require 'nokogiri'
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://www.decodethis.com/VIN-Decoded/vin/#{vin}"))
    vin = doc.css('td')[10].text
    make = doc.css('td')[18].text
    model = doc.css('td')[22].text
    trim = doc.css('td')[26].text
    year = doc.css('td')[14].text
    engine = doc.css('td')[16].text
    [vin, make, model, year, trim, engine]
  end



end

