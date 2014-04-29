class Car < ActiveRecord::Base
  attr_accessible :make, :model, :vin, :year, :miles, :description, :dealership_id, :transmission, :body_style, :exterior_color, :interior_color, :fuel, :engine, :doors, :wheel_base, :acquire_date, :acquire_price, :acquire_location, :smog_status, :smog_date, :smogged_by, :flooring, :flooring_company, :flooring_date, :license_plate, :image, :status, :trim, :wholesale_price, :retail_price, :smog_price

  belongs_to :dealership
  has_one :deal
  has_many :repairs, dependent: :destroy
  has_one :purchase, dependent: :destroy

  validates_presence_of :make, :model, :year, :acquire_price, :acquire_date, :dealership_id, :status
  validates_numericality_of :acquire_price, :smog_price, :retail_price, :wholesale_price


  has_attached_file :image, styles: { small: "115x115", medium: "320x240"}, default_url: "/car.png"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def acquire_price=(num)
    self[:acquire_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def wholesale_price=(num)
    self[:wholesale_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def retail_price=(num)
    self[:retail_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def smog_price=(num)
    self[:smog_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def vin_lookup(vin)
    require 'nokogiri'
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://www.decodethis.com/VIN-Decoded/vin/#{vin}"))
    doc.css('td')[10] != nil ?  vin = doc.css('td')[10].text : vin = ""
    doc.css('td')[18] != nil ? make = doc.css('td')[18].text : make = ""
    doc.css('td')[22] != nil ? model = doc.css('td')[22].text  : model = ""
    doc.css('td')[14] != nil ? year = doc.css('td')[14].text : year = ""
    doc.css('td')[26] != nil ? trim = doc.css('td')[26].text : trim = ""
    doc.css('td')[38] != nil ? transmission = doc.css('td')[38].text  : transmission = ""
    doc.css('td')[34] != nil ? body_style = doc.css('td')[34].text : body_style = ""
    doc.css('td')[377] != nil ? interior_color = doc.css('td')[377].text : interior_color = ""
    doc.css('td')[384] != nil ? exterior_color = doc.css('td')[384].text : exterior_color = ""
    doc.css('td')[16] != nil ? engine = doc.css('td')[16].text : engine = ""
    doc.css('td')[52] != nil && doc.css('td')[52].text.length > 3 ? wheel_base = doc.css('td')[52].text  : wheel_base = ""

    [vin, make, model, year, trim, transmission, body_style, interior_color, exterior_color, engine, wheel_base, engine]
  end

  def self.search(search)
    find(:all, :conditions => ['lower(make_model_year) LIKE ? OR lower(vin) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])
  end



end

