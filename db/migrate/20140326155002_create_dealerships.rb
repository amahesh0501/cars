class CreateDealerships < ActiveRecord::Migration
  def change
    create_table :dealerships do |t|
      t.string :dealership_name
      t.string :dealership_address
      t.string :access_code, default: "12345"

      t.timestamps
    end
  end
end
