class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :car
      t.belongs_to :dealership
      t.belongs_to :card


      t.string :name
      t.float :amount
      t.date :date
      t.string :location
      t.string :payment_method
      t.string :check_number


      t.timestamps
    end
  end
end
