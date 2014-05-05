class Repair < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id, :car_id, :vendor_id, :card_id, :payment_method, :check_number

  belongs_to :dealership
  belongs_to :car
  belongs_to :vendor
  belongs_to :card

  validates_presence_of :dealership_id, :car_id, :name, :amount, :date
  validates_numericality_of :amount


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def self.search(search)
    find(:all, :conditions => ['lower(description) LIKE ? OR lower(name) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])
  end

end
