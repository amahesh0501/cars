class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id, :vendor_id, :card_id, :payment_method, :check_number, :partner_id

  belongs_to :dealership
  belongs_to :vendor
  belongs_to :partner
  belongs_to :card


  validates_presence_of :name, :dealership_id, :amount, :date
  validates_numericality_of :amount


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def self.search(search)
    find(:all, :conditions => ['lower(description) LIKE ? OR lower(name) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])  end

end
