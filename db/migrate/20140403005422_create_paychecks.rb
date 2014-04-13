class CreatePaychecks < ActiveRecord::Migration
  def change
    create_table :paychecks do |t|
      t.belongs_to :employee
      t.belongs_to :dealership

      t.string :name
      t.float :amount
      t.text :description
      t.date :date




      t.timestamps

    end
  end
end
