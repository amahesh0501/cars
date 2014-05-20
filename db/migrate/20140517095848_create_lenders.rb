class CreateLenders < ActiveRecord::Migration
  def change
    create_table :lenders do |t|
      t.belongs_to :dealership
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.attachment :image
      t.text :description

      #components
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_city
      t.string :address_state
      t.string :address_zip

      t.timestamps
    end
  end
end
