class UsersController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @user = User.find(params[:id])
    @membership = Membership.find_by_user_id(@user.id)
    @dealership = Dealership.find(@membership.dealership_id)
  end
end