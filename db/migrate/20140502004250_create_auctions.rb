class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
    	t.belongs_to :dealership

    	t.string :name
    	t.string :address_line_1
    	t.string :address_line_2
    	t.string :address_city
    	t.string :address_state
    	t.string :address_zip
    	t.string :address
    	t.string :contact_name
    	t.string :phone
    	t.string :email

    	t.text :description

        t.attachment :image


    	t.timestamps
    end
  end
end
