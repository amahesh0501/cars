class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :car
      t.belongs_to :user
      t.belongs_to :dealership

      t.string :name
      t.integer :amount
      t.text :description
      t.date :date

      t.belongs_to :vendor


      t.timestamps

    end
  end
end
