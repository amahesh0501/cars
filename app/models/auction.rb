class Auction < ActiveRecord::Base
  attr_accessible :name, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip, :address, :contact_name, :phone, :email, :dealership_id, :image

  belongs_to :dealership
  has_many :cars

  validates_presence_of :dealership_id

  has_attached_file :image, styles: { small: "115x115", medium: "320x240"}, default_url: "/car.png"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

end