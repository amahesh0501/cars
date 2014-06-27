class Card < ActiveRecord::Base
  attr_accessible :name, :number, :dealership_id

  belongs_to :dealership
  has_many :expenses
  has_many :paychecks
  has_many :repairs
  has_many :purchases
  has_many :payments


end