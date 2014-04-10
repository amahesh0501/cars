class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :dealership
      t.string :email_address
      t.boolean :has_access, :default => false
      t.boolean :is_dealership_admin, :default => false

      t.timestamps
    end
  end
end
