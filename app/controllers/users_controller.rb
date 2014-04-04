class UsersController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @user = User.find(params[:id])
    @membership = Membership.find_by_user_id(@user.id)
    @dealership = Dealership.find(@membership.dealership_id)
    @paychecks = Paycheck.where(user_id: @user.id)
    @deals = Deal.where(user_id: @user.id)
    @cars = []
    @deals.each {|deal| @cars << Car.find(deal.car_id)}
  end
end