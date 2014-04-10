class CreateRevenues < ActiveRecord::Migration
  def change
    create_table :revenues do |t|
      t.belongs_to :dealership

      t.string :name
      t.integer :amount
      t.text :description
      t.date :date




      t.timestamps

    end
  end
end
