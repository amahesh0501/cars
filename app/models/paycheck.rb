class Paycheck < ActiveRecord::Base
  attr_accessible :amount, :description, :date, :dealership_id, :employee_id, :name, :card_id, :payment_method, :check_number

  belongs_to :dealership
  belongs_to :employee
  belongs_to :card


  validates_presence_of :dealership_id, :employee_id, :amount, :date
  validates_numericality_of :amount


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def self.search(search)
    find(:all, :conditions => ['lower(description) LIKE ? ', "%#{search.downcase}%"])
  end

end
