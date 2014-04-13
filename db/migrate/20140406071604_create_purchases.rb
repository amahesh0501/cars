class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :car
      t.belongs_to :dealership

      t.string :name
      t.integer :float
      t.date :date
      t.string :location

      t.timestamps
    end
  end
end
