class Employee < ActiveRecord::Base
  attr_accessible :name, :ssn, :email, :phone, :address, :image

  has_many :deals
  has_many :paychecks
  has_many :conversations

  has_attached_file :image, styles: { medium: "320x240"}
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }



end
