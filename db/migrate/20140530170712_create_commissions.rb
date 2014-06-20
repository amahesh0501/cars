class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.belongs_to :car
      t.belongs_to :dealership
      t.belongs_to :employee

      t.date :date
      t.float :amount


    end
  end
end
