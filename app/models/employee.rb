class Employee < ActiveRecord::Base
  attr_accessible :name, :ssn, :email, :phone, :address, :image, :dealership_id, :description

  belongs_to :dealership
  has_many :deals
  has_many :paychecks
  has_many :conversations

  validates_presence_of :dealership_id, :name

  has_attached_file :image, styles: { medium: "320x240"}, default_url: "/profile.png"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def self.search(search)
    find(:all, :conditions => ['lower(name) LIKE ? OR lower(address) LIKE ? OR lower(phone) LIKE ? OR lower(email) LIKE ? OR lower(ssn) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"])
  end



end
