class Paycheck < ActiveRecord::Base
  attr_accessible :amount, :description, :date, :dealership_id, :employee_id

  belongs_to :dealership
  belongs_to :employee
end
