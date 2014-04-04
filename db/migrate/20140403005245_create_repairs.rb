class CreateRepairs < ActiveRecord::Migration
  def change
    create_table :repairs do |t|
      t.belongs_to :car
      t.belongs_to :dealership
      t.belongs_to :vendor

      t.string :name
      t.integer :amount
      t.text :description
      t.date :date




      t.timestamps

    end
  end
end



