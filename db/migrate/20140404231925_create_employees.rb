class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.belongs_to :dealership
      t.string :name
      t.string :email
      t.string :ssn
      t.string :address
      t.string :phone
      t.text :description
      t.attachment :image

      t.timestamps

    end
  end
end
