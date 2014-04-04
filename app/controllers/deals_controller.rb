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
    @dealership = Dealership.find(params[:dealership_id])
    if @deal.save
      @dealership.deals << @deal
      @car = Car.find(@deal.car_id)
      @car.status = "Sold"
      @car.save
      @customer = Customer.find(@deal.customer_id)
      @customer.status = "Existing Customer"
      @customer.save
      redirect_to dealership_deal_path(@dealership, @deal)
    else
      flash.now[:errors] = @deal.errors.full_messages
      redirect_to new_dealership_deal_path(@dealership)
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
    car = Car.find(deal.car_id)
    car.status = "Frontline"
    car.save
    deal.destroy
    redirect_to root_path
  end


end