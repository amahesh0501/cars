class Gap < ActiveRecord::Base
  attr_accessible :name, :address, :contact_name, :contact_phone, :contact_email, :dealership_id, :image, :description, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip

  belongs_to :dealership
  has_many :deals
  has_many :temps
  has_many :repairs

  validates_presence_of :dealership_id, :name
  has_attached_file :image, styles: { medium: "320x240"}, default_url: "/vendor.jpg"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def self.search(search)
    find(:all, :conditions => ['lower(name) LIKE ? OR lower(address_line_1) LIKE ? OR lower(contact_name) LIKE ? OR lower(contact_email) LIKE ? OR lower(contact_phone) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"])
  end




end