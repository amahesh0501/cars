class Revenue < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id

  belongs_to :dealership

  validates_presence_of :dealership_id, :name, :amount, :date

end
