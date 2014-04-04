class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.belongs_to :car
      t.belongs_to :customer
      t.belongs_to :user
      t.belongs_to :dealership
      t.date :date
      t.integer :purchase_price
      t.integer :sales_tax_amount
      t.integer :down_payment
      t.integer :term
      t.integer :apr
      t.integer :trade_in_value
      t.boolean :gap_insurance, default: false
      t.string :gap_name

      t.timestamps
    end
  end
end
