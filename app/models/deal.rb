class Deal < ActiveRecord::Base
  attr_accessible :user_id, :car_id, :customer_id, :dealership_id, :purchase_price, :sales_tax_amount, :down_payment, :apr, :term, :trade_in_value, :gap_insurance, :gap_name

  belongs_to :dealership
  belongs_to :customer
  belongs_to :user
  belongs_to :car
end
