class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.belongs_to :dealership
      t.string :name
      t.text :description
      t.attachment :form_pdf


    end
  end
end
