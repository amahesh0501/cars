class Membership < ActiveRecord::Base
  attr_accessible :user_id, :dealership_id
  belongs_to :user
  belongs_to :dealership

  def can_access?(membership)
    membership && !membership.revoked ? true : false
  end

  def revoked?(membership)
    membership.revoked
  end




end