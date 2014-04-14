class Dealership < ActiveRecord::Base

  attr_accessible :dealership_name, :dealership_address, :access_code, :active

  has_many :customers
  has_many :cars
  has_many :deals
  has_many :memberships
  has_many :employees
  has_many :expenses
  has_many :repairs
  has_many :paychecks
  has_many :vendors
  has_many :conversations
  has_many :purchases
  has_many :revenues
  has_many :forms

  validates_presence_of :dealership_name

  def grant_access(code)
      code == self.access_code ? true : false
  end

end