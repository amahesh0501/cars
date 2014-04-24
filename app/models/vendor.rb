class Vendor < ActiveRecord::Base
  attr_accessible :name, :address, :contact_name, :contact_phone, :contact_email, :dealership_id, :image, :description

  has_many :expenses
  belongs_to :dealership

  validates_presence_of :dealership_id, :name
  has_attached_file :image, styles: { medium: "320x240"}, default_url: "/vendor.jpg"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def self.search(search)
    find(:all, :conditions => ['lower(name) LIKE ? OR lower(address) LIKE ? OR lower(contact_name) LIKE ? OR lower(contact_email) LIKE ? OR lower(contact_phone) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"])
  end



end