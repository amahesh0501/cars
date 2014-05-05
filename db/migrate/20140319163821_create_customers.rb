class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.belongs_to :dealership
      t.string :name
      t.string :address
      t.string :time_at_residence
      t.string :phone
      t.string :email
      t.date :dob
      t.string :ssn
      t.text :notes
      t.string :driver_license_number
      t.string :employer
      t.string :employer_contact
      t.string :employer_title
      t.string :employer_address
      t.string :employer_phone
      t.float :monthly_gross_salary
      t.integer :time_at_employer

      t.string :status, default: "Potential Customer"

      #components
       t.string :first
       t.string :last
       t.string :address_line_1
       t.string :address_line_2
       t.string :address_city
       t.string :address_state
       t.string :address_zip

       t.string :employer_address_line_1
       t.string :employer_address_line_2
       t.string :employer_address_city
       t.string :employer_address_state
       t.string :employer_address_zip

        #images
        t.attachment :image
        t.attachment :license_photo


      t.timestamps
    end
  end
end
