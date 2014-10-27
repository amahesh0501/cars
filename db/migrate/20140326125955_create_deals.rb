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
      t.float :amount
      t.float :sales_tax_amount
      t.float :sales_tax_percent
      t.float :down_payment
      t.integer :term, default: 1
      t.float :apr
      t.float :commission



      t.float :trade_in_value
      t.float :less_payoff

      t.float :deffered_down_1_payment
      t.date :deffered_down_1_date
      t.float :deffered_down_2_payment
      t.date :deffered_down_2_date
      t.float :deffered_down_3_payment
      t.date :deffered_down_3_date

      t.float :smog_fee
      t.float :other_fee
      t.float :doc_fee
      t.float :reg_fee

      t.float :warranty_term
      t.float :warranty_price
      t.float :warranty_cost
      t.string :warranty_type

      t.float :gap_term
      t.float :gap_price
      t.float :gap_cost

      t.float :accessory_price
      t.float :accessory_cost

      t.float :discount_fee


      t.date :first_payment_date

      t.timestamps
    end
  end
end
