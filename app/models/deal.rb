class Deal < ActiveRecord::Base
  attr_accessible :employee_id, :car_id, :customer_id, :dealership_id, :amount, :sales_tax_percent, :sales_tax_amount, :date, :down_payment, :apr, :term, :trade_in_value, :gap_insurance, :gap_name

  belongs_to :dealership
  belongs_to :customer
  belongs_to :employee
  belongs_to :car

  validates_presence_of :dealership_id, :car_id, :customer_id, :date, :amount
  validates_uniqueness_of :car_id, message: "already has a deal associated with it. Please delete that deal to create a new one"
  validates_numericality_of :amount, :sales_tax_amount, :sales_tax_percentm, :term, :down_payment, :apr, :trade_in_value


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def sales_tax_amount=(num)
    self[:sales_tax_amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def down_payment=(num)
    self[:down_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def trade_in_value=(num)
    self[:trade_in_value] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def quick_calculate

  end

end
