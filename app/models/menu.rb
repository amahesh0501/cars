class Menu < ActiveRecord::Base
  attr_accessible :name, :basic_one_title, :basic_one_description, :basic_one_amount, :basic_two_title, :basic_two_description, :basic_two_amount, :basic_three_title, :basic_three_description, :basic_three_amount, :basic_four_title, :basic_four_description, :basic_four_amount, :basic_five_title, :basic_five_description, :basic_five_amount, :standard_one_title, :standard_one_description, :standard_one_amount, :standard_two_title, :standard_two_description, :standard_two_amount, :standard_three_title, :standard_three_description, :standard_three_amount, :standard_four_title, :standard_four_description, :standard_four_amount, :standard_five_title, :standard_five_description, :standard_five_amount, :good_one_title, :good_one_description, :good_one_amount, :good_two_title, :good_two_description, :good_two_amount, :good_three_title, :good_three_description, :good_three_amount, :good_four_title, :good_four_description, :good_four_amount, :good_five_title, :good_five_description, :good_five_amount, :best_one_title, :best_one_description, :best_one_amount, :best_two_title, :best_two_description, :best_two_amount, :best_three_title, :best_three_description, :best_three_amount, :best_four_title, :best_four_description, :best_four_amount, :best_five_title, :best_five_description, :best_five_amount, :dealership_id

  belongs_to :dealership



end