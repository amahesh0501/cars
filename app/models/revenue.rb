class Revenue < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id

  belongs_to :dealership

  validates_presence_of :dealership_id, :name, :amount, :date

  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

end
