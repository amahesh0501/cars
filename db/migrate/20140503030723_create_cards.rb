class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :dealership
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
