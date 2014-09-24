class Auction < ActiveRecord::Base
  attr_accessible :name, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip, :address, :contact_name, :phone, :email, :dealership_id, :image, :description

  belongs_to :dealership
  has_many :cars

  validates_presence_of :dealership_id

  has_attached_file :image, styles: { small: "115x115", medium: "320x240"}, default_url: "/biz.jpg"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def self.search(search)
    find(:all, :conditions => ['lower(name) LIKE ? OR lower(address_line_1) LIKE ? OR lower(contact_name) LIKE ? OR lower(email) LIKE ? OR lower(phone) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"])
  end

end