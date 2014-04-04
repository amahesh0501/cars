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
      t.integer :monthly_gross_salary
      t.integer :time_at_employer

      t.string :status


      t.timestamps
    end
  end
end
