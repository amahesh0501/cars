class Deal < ActiveRecord::Base
  attr_accessible :employee_id, :car_id, :customer_id, :dealership_id, :warranty_id, :gap_id, :lender_id, :amount, :sales_tax_percent, :sales_tax_amount, :date, :down_payment, :apr, :term, :trade_in_value, :less_payoff, :days_to_first_payment, :deffered_down_1_payment, :deffered_down_1_date, :deffered_down_2_payment, :deffered_down_2_date, :deffered_down_3_payment, :deffered_down_3_date, :smog_fee, :doc_fee, :reg_fee, :warranty_term, :warranty_price, :warranty_type, :gap_term, :gap_price, :discount_fee, :other_fee, :commission


  belongs_to :dealership
  belongs_to :customer
  belongs_to :employee
  belongs_to :car
  belongs_to :warranty
  belongs_to :gap
  belongs_to :lender

  validates_presence_of :dealership_id, :car_id, :customer_id, :date, :amount
  validates_uniqueness_of :car_id, message: "already has a deal associated with it. Please delete that deal to create a new one"
  validates_numericality_of :amount, :sales_tax_amount, :sales_tax_percent, :term, :down_payment, :apr, :trade_in_value


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
  def less_payoff=(num)
    self[:less_payoff] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def deffered_down_1_payment=(num)
    self[:deffered_down_1_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def deffered_down_2_payment=(num)
    self[:deffered_down_2_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def deffered_down_3_payment=(num)
    self[:deffered_down_3_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def smog_fee=(num)
    self[:smog_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def doc_fee=(num)
    self[:doc_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def reg_fee=(num)
    self[:reg_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def warranty_price=(num)
    self[:warranty_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def warranty_cost=(num)
    self[:warranty_cost] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def gap_price=(num)
    self[:gap_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def gap_cost=(num)
    self[:gap_cost] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def discount_fee=(num)
    self[:discount_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end
  def commission=(num)
    self[:commission] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end


end
