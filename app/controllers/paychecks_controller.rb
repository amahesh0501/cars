class PaychecksController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    paycheck = Paycheck.find(params[:id])
    redirect_to user_path(User.find(paycheck.user_id))
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @paycheck = Paycheck.new
    @users = []
    @memberships = Membership.where(dealership_id: @dealership.id)
    @memberships.each {|membership| @users << User.find(membership.user_id)}
  end

  def create
    authenticate_user!
    @paycheck = Paycheck.new(params[:paycheck])
    dealership = Dealership.find(params[:dealership_id])
    user = User.find(@paycheck.user_id)
    if @paycheck.save
      dealership.paychecks << @paycheck
      redirect_to user_path(user)
    else
      flash.now[:errors] = @paycheck.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @paycheck = Paycheck.find(params[:id])
    @users = []
    @memberships = Membership.where(dealership_id: @dealership.id)
    @memberships.each {|membership| @users << User.find(membership.user_id)}
  end

  def update
    authenticate_user!
    paycheck = Paycheck.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    user = User.find(paycheck.user_id)
    if paycheck.update_attributes(params[:paycheck])
      redirect_to user_path(user)
    else
      flash.now[:errors] = paycheck.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    paycheck = Paycheck.find(params[:id])
    paycheck.destroy
    redirect_to root_path
  end



end

