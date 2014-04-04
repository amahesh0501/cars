class Paycheck < ActiveRecord::Base
  attr_accessible :amount, :description, :date, :dealership_id, :user_id

  belongs_to :dealership
  belongs_to :user
end
