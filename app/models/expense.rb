class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id, :vendor_id


  belongs_to :dealership
  belongs_to :vendor
end
