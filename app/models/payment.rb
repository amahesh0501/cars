class Payment < ActiveRecord::Base
  attr_accessible :date, :amount, :card_id, :dealership_id

  belongs_to :dealership
  belongs_to :card

  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

end