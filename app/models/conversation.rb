class Conversation < ActiveRecord::Base
  attr_accessible :date, :description, :medium, :dealership_id, :employee_id, :customer_id

  belongs_to :dealership
  belongs_to :employee
  belongs_to :customer

  validates_presence_of :date, :dealership_id, :customer_id, :description

  def self.search(search)
    find(:all, :conditions => ['lower(description) LIKE ? OR lower(medium) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%"])
  end

end