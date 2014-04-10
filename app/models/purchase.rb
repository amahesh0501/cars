class Purchase < ActiveRecord::Base
  attr_accessible :location, :amount, :description, :date, :dealership_id, :car_id

  belongs_to :dealership
  belongs_to :car

  validates_presence_of :dealership_id, :car_id, :amount, :date

end
