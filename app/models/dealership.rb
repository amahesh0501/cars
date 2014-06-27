class Dealership < ActiveRecord::Base

  attr_accessible :dealership_name, :dealership_address, :active, :sales_tax, :start_balance

  has_many :customers
  has_many :cars
  has_many :deals
  has_many :temps
  has_many :memberships
  has_many :employees
  has_many :expenses
  has_many :repairs
  has_many :paychecks
  has_many :vendors
  has_many :conversations
  has_many :purchases
  has_many :revenues
  has_many :forms
  has_many :auctions
  has_many :floorers
  has_many :cards
  has_many :gaps
  has_many :warranties
  has_many :lenders
  has_many :partners
  has_many :commissions
  has_many :payments
  has_many :menus


  validates_presence_of :dealership_name


end