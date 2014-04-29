class Customer < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :email, :ssn, :notes, :time_at_residence, :dob, :driver_license_number, :employer, :employer_contact, :employer_title, :employer_address, :employer_phone, :time_at_employer, :monthly_gross_salary, :dealership_id, :image, :status, :first, :last, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip, :license_photo

  belongs_to :dealership
  has_many :deals
  has_many :conversations, dependent: :destroy

  validates_presence_of :name, :dealership_id, :status
  validates_numericality_of :monthly_gross_salary, :address_zip

  has_attached_file :image, styles: { medium: "320x240"}, default_url: "/profile.png"
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  has_attached_file :license_photo, styles: { medium: "320x240"}, default_url: "/profile.png"
  validates_attachment :license_photo, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }

  def monthly_gross_salary=(num)
    self[:monthly_gross_salary] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def self.search(search)
    find(:all, :conditions => ['lower(name) LIKE ? OR lower(address) LIKE ? OR lower(phone) LIKE ? OR lower(email) LIKE ? OR lower(ssn) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%", "%#{search.downcase}%"])
  end


end