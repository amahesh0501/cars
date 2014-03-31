class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :ssn, :email, :phone, :address, :age, :password, :user_type

  has_many :memberships
  has_many :deals
  has_many :expenses

end

