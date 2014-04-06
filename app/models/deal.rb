class Deal < ActiveRecord::Base
  attr_accessible :employee_id, :car_id, :customer_id, :dealership_id, :purchase_price, :sales_tax_amount, :date, :down_payment, :apr, :term, :trade_in_value, :gap_insurance, :gap_name

  belongs_to :dealership
  belongs_to :customer
  belongs_to :employee
  belongs_to :car
  before_save :check_car

  def check_car
    return false if Deal.find_by_car_id(self.car_id)
  end

end
