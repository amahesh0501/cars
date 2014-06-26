class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
    	t.belongs_to :dealership
    	t.belongs_to :card

    	t.date :date
    	t.float :amount

    	t.timestamps
    end
  end
end
