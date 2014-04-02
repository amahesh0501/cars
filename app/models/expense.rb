class Expense < ActiveRecord::Base
  attr_accessible :car_id, :user_id, :name, :amount, :description, :date, :dealership_id, :vendor_id

  belongs_to :car
  belongs_to :user
  belongs_to :dealership
  belongs_to :vendor
end
