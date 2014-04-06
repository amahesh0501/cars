class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.belongs_to :dealership
      t.belongs_to :employee
      t.belongs_to :customer

      t.date :date
      t.text :description
      t.string :medium

      t.timestamps
    end
  end
end
