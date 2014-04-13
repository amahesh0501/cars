class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.belongs_to :car
      t.belongs_to :customer
      t.belongs_to :employee
      t.belongs_to :dealership
      t.date :date
      t.float :amount
      t.float :sales_tax_amount
      t.float :down_payment
      t.integer :term
      t.integer :apr
      t.float :trade_in_value
      t.boolean :gap_insurance, default: false
      t.string :gap_name

      t.timestamps
    end
  end
end
