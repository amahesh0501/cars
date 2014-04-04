class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :ssn, :email, :phone, :address, :age, :password, :user_type, :image

  has_many :memberships
  has_many :deals
  has_many :expenses
  has_many :conversations

  has_attached_file :image, styles: { medium: "320x240"}
  validates_attachment :image, content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }, size: { less_than: 5.megabytes }



end

