class DealsController < ApplicationController

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @customer = Customer.find(@deal.customer_id)
    @user = User.find(@deal.user_id)
    @car = Car.find(@deal.car_id)
  end

  def new
    authenticate_user!
    @deal = Deal.new
    @dealership = Dealership.find(params[:dealership_id])

    @users = []
    @memberships = Membership.where(dealership_id: @dealership.id)
    @memberships.each {|membership| @users << User.find(membership.user_id)}

    @cars = @dealership.cars
    @customers = @dealership.customers
  end

  def create
    authenticate_user!
    @deal = Deal.new(params[:deal])
    if @deal.save
      dealership = Dealership.find(params[:dealership_id])
      dealership.deals << @deal
      redirect_to dealership_deal_path(dealership, @deal)
    else
      flash.now[:errors] = @deal.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])

    @users = []
    @memberships = Membership.where(dealership_id: @dealership.id)
    @memberships.each {|membership| @users << User.find(membership.user_id)}

    @cars = @dealership.cars
    @customers = @dealership.customers

  end

  def update
    authenticate_user!
    deal = Deal.find(params[:id])
    if deal.update_attributes(params[:deal])
      dealership = Dealership.find(params[:dealership_id])
      redirect_to dealership_deal_path(dealership, deal)
    else
      flash.now[:errors] = deal.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    deal = Deal.find(params[:id])
    deal.destroy
    redirect_to root_path
  end


end