class Conversation < ActiveRecord::Base
  attr_accessible :date, :description, :medium, :dealership_id, :user_id, :customer_id

  belongs_to :dealership
  belongs_to :user
  belongs_to :customer
end