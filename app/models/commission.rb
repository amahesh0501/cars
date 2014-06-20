class Commission < ActiveRecord::Base
  attr_accessible :amount, :date, :dealership_id, :car_id, :employee_id

  belongs_to :dealership
  belongs_to :car
  belongs_to :employee

  validates_presence_of :dealership_id, :amount, :car_id
  validates_numericality_of :amount


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end


end
