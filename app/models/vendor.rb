class Vendor < ActiveRecord::Base
  attr_accessible :name, :address, :contact_name, :contact_phone, :contact_email, :dealership_id

  has_many :expenses
  belongs_to :dealership

  validates_presence_of :dealership_id, :name

end