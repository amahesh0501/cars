class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id, :vendor_id

  belongs_to :dealership
  belongs_to :vendor

  validates_presence_of :name, :dealership_id, :amount, :date

end
