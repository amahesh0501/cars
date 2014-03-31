class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :dealership
      t.boolean :revoked, :default => false

      t.timestamps
    end
  end
end
