class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.belongs_to :dealership
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.attachment :image
      t.text :description

      t.timestamps
    end
  end
end
