class Dealership < ActiveRecord::Base

  attr_accessible :dealership_name, :dealership_address, :access_code

  has_many :customers
  has_many :cars
  has_many :deals
  has_many :memberships
  has_many :expenses
  has_many :repairs
  has_many :paychecks
  has_many :vendors
  has_many :conversations

  def grant_access(code)
      code == self.access_code ? true : false
  end

end