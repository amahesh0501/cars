class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|

    	t.belongs_to :dealership
        t.string :name

    	t.string :basic_one_title
    	t.text :basic_one_description
    	t.float :basic_one_amount

    	t.string :basic_two_title
    	t.text :basic_two_description
    	t.float :basic_two_amount

    	t.string :basic_three_title
    	t.text :basic_three_description
    	t.float :basic_three_amount

    	t.string :basic_four_title
    	t.text :basic_four_description
    	t.float :basic_four_amount

    	t.string :basic_five_title
    	t.text :basic_five_description
    	t.float :basic_five_amount

    	t.string :standard_one_title
    	t.text :standard_one_description
    	t.float :standard_one_amount

    	t.string :standard_two_title
    	t.text :standard_two_description
    	t.float :standard_two_amount

    	t.string :standard_three_title
    	t.text :standard_three_description
    	t.float :standard_three_amount

    	t.string :standard_four_title
    	t.text :standard_four_description
    	t.float :standard_four_amount

    	t.string :standard_five_title
    	t.text :standard_five_description
    	t.float :standard_five_amount

    	t.string :good_one_title
    	t.text :good_one_description
    	t.float :good_one_amount

    	t.string :good_two_title
    	t.text :good_two_description
    	t.float :good_two_amount

    	t.string :good_three_title
    	t.text :good_three_description
    	t.float :good_three_amount

    	t.string :good_four_title
    	t.text :good_four_description
    	t.float :good_four_amount

    	t.string :good_five_title
    	t.text :good_five_description
    	t.float :good_five_amount

    	t.string :best_one_title
    	t.text :best_one_description
    	t.float :best_one_amount

    	t.string :best_two_title
    	t.text :best_two_description
    	t.float :best_two_amount

    	t.string :best_three_title
    	t.text :best_three_description
    	t.float :best_three_amount

    	t.string :best_four_title
    	t.text :best_four_description
    	t.float :best_four_amount

    	t.string :best_five_title
    	t.text :best_five_description
    	t.float :best_five_amount



    end
  end
end
