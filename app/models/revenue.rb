class Revenue < ActiveRecord::Base
  attr_accessible :name, :amount, :description, :date, :dealership_id

  belongs_to :dealership

  validates_presence_of :dealership_id, :name, :amount, :date
  validates_numericality_of :amount


  def amount=(num)
    self[:amount] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  def self.search(search)
    find(:all, :conditions => ['lower(description) LIKE ? OR lower(name) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])
  end

end
