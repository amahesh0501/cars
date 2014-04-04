class CreatePaychecks < ActiveRecord::Migration
  def change
    create_table :paychecks do |t|
      t.belongs_to :user
      t.belongs_to :dealership

      t.integer :amount
      t.text :description
      t.date :date




      t.timestamps

    end
  end
end
