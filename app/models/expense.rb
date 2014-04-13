class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id, :vendor_id

  belongs_to :dealership
  belongs_to :vendor

  validates_presence_of :name, :dealership_id, :amount, :date

  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

end
