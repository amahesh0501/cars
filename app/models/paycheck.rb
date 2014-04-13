class Paycheck < ActiveRecord::Base
  attr_accessible :amount, :description, :date, :dealership_id, :employee_id, :name

  belongs_to :dealership
  belongs_to :employee

  validates_presence_of :dealership_id, :employee_id, :amount, :date

  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

end
