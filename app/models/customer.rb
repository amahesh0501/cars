class Customer < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :email, :ssn, :notes, :time_at_residence, :dob, :driver_license_number, :employer, :employer_contact, :employer_title, :employer_address, :employer_phone, :time_at_employer, :monthly_gross_salary, :dealership_id
  validates :name, :address, :phone, :email, presence: true
  belongs_to :dealership
  has_many :deals
  has_many :conversations
end