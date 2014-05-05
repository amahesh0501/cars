class RepairsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    redirect_to root_path
  end

  def show
    @membership = Membership.find_by_user_id(current_user.id)
    @dealership = Dealership.find(params[:dealership_id])
    @repair = Repair.find(params[:id])
    @car = Car.find(@repair.car_id)
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:repair] ? @repair = Repair.new(flash[:repair]) : @repair = Repair.new
    @cars = @dealership.cars
    @vendors = @dealership.vendors.where(category: "Vehicle Maintenance")
    @cards = @dealership.cards
  end

  def create
    @repair = Repair.new(params[:repair])
    @car = Car.find(@repair.car_id) if @repair.car_id
    dealership = Dealership.find(params[:dealership_id])
    @repair.dealership_id = dealership.id
    if @repair.save
      redirect_to dealership_repair_path(dealership, @repair)

    else
      flash[:errors] = @repair.errors.full_messages
      flash[:repair] = params[:repair]
      redirect_to new_dealership_repair_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @repair = Repair.find(params[:id])
    @cars = @dealership.cars
    @vendors = @dealership.vendors
    @fields = flash[:repair] if flash[:repair]
    @cards = @dealership.cards
  end

  def update
    repair = Repair.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(repair.car_id)
    if repair.update_attributes(params[:repair])
      redirect_to dealership_repair_path(dealership, repair)
    else
      flash[:errors] = repair.errors.full_messages
      flash[:repair] = params[:repair]
      redirect_to edit_dealership_repair_path(dealership, repair)
    end
  end

  def destroy
    repair = Repair.find(params[:id])
    car = Car.find(repair.car_id)
    dealership = Dealership.find(params[:dealership_id])
    repair.destroy
    redirect_to dealership_car_path(dealership, car)
  end



end

