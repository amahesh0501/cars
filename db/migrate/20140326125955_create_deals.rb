class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.belongs_to :car
      t.belongs_to :customer
      t.belongs_to :employee
      t.belongs_to :dealership
      t.belongs_to :warranty
      t.belongs_to :gap
      t.belongs_to :lender

      t.date :date
      t.float :amount, default: 0
      t.float :sales_tax_amount, default: 0
      t.float :sales_tax_percent, default: 0
      t.float :down_payment, default: 0
      t.integer :term, default: 1
      t.integer :apr, default: 0
      t.float :commission, default: 0



      t.float :trade_in_value, default: 0
      t.float :less_payoff, default: 0

      t.float :deffered_down_1_payment, default: 0
      t.date :deffered_down_1_date
      t.float :deffered_down_2_payment, default: 0
      t.date :deffered_down_2_date
      t.float :deffered_down_3_payment, default: 0
      t.date :deffered_down_3_date

      t.float :smog_fee, default: 0
      t.float :other_fee, default: 0
      t.float :doc_fee, default: 0
      t.float :reg_fee, default: 0

      t.float :warranty_term, default: 0
      t.float :warranty_price, default: 0
      t.float :warranty_cost, default: 0
      t.string :warranty_type

      t.float :gap_term, default: 0
      t.float :gap_price, default: 0
      t.float :gap_cost, default: 0

      t.float :accessory_price, default: 0
      t.float :accessory_cost, default: 0

      t.float :discount_fee, default: 0


      t.date :first_payment_date

      t.timestamps
    end
  end
end
