class Repair < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id, :car_id, :vendor_id

  belongs_to :dealership
  belongs_to :car
  belongs_to :vendor

  validates_presence_of :dealership_id, :car_id, :name, :amount, :date

end
