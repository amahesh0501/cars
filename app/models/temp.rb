class Temp < ActiveRecord::Base
  attr_accessible :employee_id, :car_id, :customer_id, :dealership_id, :warranty_id, :gap_id, :lender_id, :amount, :sales_tax_percent, :sales_tax_amount, :date, :down_payment, :apr, :term, :trade_in_value, :less_payoff, :days_to_first_payment, :deffered_down_1_payment, :deffered_down_1_date, :deffered_down_2_payment, :deffered_down_2_date, :deffered_down_3_payment, :deffered_down_3_date, :smog_fee, :doc_fee, :reg_fee, :warranty_term, :warranty_price, :warranty_type, :gap_term, :gap_price, :discount_fee, :other_fee, :accessory_price, :estimated_commission, :accessory_cost, :gap_cost, :warranty_cost             


  belongs_to :dealership
  belongs_to :customer
  belongs_to :employee
  belongs_to :car
  belongs_to :warranty
  belongs_to :gap
  belongs_to :lender


  # def amount=(num)
  #   self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:amount]
  # end
  # def sales_tax_amount=(num)
  #   self[:sales_tax_amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:sales_tax_amount] 
  # end
  # def down_payment=(num)
  #   self[:down_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:down_payment]
  # end
  # def trade_in_value=(num)
  #   self[:trade_in_value] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:trade_in_value]
  # end
  # def deffered_down_1_payment=(num)
  #   self[:deffered_down_1_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:deffered_down_1_payment]
  # end
  # def deffered_down_2_payment=(num)
  #   self[:deffered_down_2_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:deffered_down_2_payment]
  # end
  # def deffered_down_3_payment=(num)
  #   self[:deffered_down_3_payment] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:deffered_down_3_payment]
  # end
  # def smog_fee=(num)
  #   self[:smog_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:smog_fee]
  # end
  # def doc_fee=(num)
  #   self[:doc_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:doc_fee]
  # end
  # def reg_fee=(num)
  #   self[:reg_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:reg_fee] 
  # end
  # def other_fee=(num)
  #   self[:other_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:other_fee]
  # end
  # def warranty_price=(num)
  #   self[:warranty_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:warranty_price]
  # end
  # def warranty_cost=(num)
  #   self[:warranty_cost] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:warranty_cost]
  # end
  # def gap_price=(num)
  #   self[:gap_price] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:gap_price]
  # end
  # def gap_cost=(num)
  #   self[:gap_cost] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:gap_cost]
  # end
  # def discount_fee=(num)
  #   self[:discount_fee] = num.to_s.scan(/\b-?[\d.]+/).join.to_f if self[:discount_fee]
  # end

  def taxable_amount
    taxable_amount = 0 
    taxable_amount = taxable_amount + self.amount if self.amount
    taxable_amount = taxable_amount + self.smog_fee if self.smog_fee
    taxable_amount = taxable_amount + self.doc_fee if self.doc_fee
    taxable_amount = taxable_amount + self.reg_fee if self.reg_fee
    taxable_amount = taxable_amount + self.other_fee if self.other_fee
    taxable_amount = taxable_amount + self.gap_price if self.gap_price
    taxable_amount = taxable_amount + self.warranty_price if self.warranty_price
    taxable_amount = taxable_amount - self.trade_in_value if self.trade_in_value
    taxable_amount = taxable_amount + self.less_payoff if self.less_payoff
    return taxable_amount
    return taxable_amount
  end


end
