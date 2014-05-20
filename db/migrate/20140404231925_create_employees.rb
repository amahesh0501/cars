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



      #components
       t.string :first
       t.string :last
       t.string :address_line_1
       t.string :address_line_2
       t.string :address_city
       t.string :address_state
       t.string :address_zip
       t.integer :number
       t.date :birthday
       t.date :hire_date
       t.date :terminate_date
       t.string :title
       t.string :driver_license_number
       t.string :sales_license

       #images
       t.attachment :image
       t.attachment :license_photo


      t.timestamps

    end
  end
end
