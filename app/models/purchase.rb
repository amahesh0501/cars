class Purchase < ActiveRecord::Base
  attr_accessible :location, :amount, :description, :date, :dealership_id, :car_id, :card_id, :payment_method, :check_number

  belongs_to :dealership
  belongs_to :car
  belongs_to :card


  validates_presence_of :dealership_id, :car_id, :amount, :date
  validates_numericality_of :amount


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

end
