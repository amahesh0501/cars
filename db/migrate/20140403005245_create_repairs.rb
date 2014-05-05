class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.belongs_to :car
      t.belongs_to :dealership
      t.belongs_to :vendor
      t.belongs_to :card


      t.string :name
      t.float :amount
      t.text :description
      t.date :date
      t.string :payment_method
      t.string :check_number





      t.timestamps

    end
  end
end



