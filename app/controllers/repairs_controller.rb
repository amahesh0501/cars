class RepairsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @repair = Repair.find(params[:id])
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @repair = Repair.new
    @cars = @dealership.cars
    @vendors = @dealership.vendors
  end

  def create
    authenticate_user!
    @repair = Repair.new(params[:repair])
    @car = Car.find(@repair.car_id)
    dealership = Dealership.find(params[:dealership_id])
    if @repair.save
      dealership.repairs << @repair
      redirect_to dealership_car_path(dealership, @car)
    else
      flash.now[:errors] = @repair.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @repair = Repair.find(params[:id])
    @cars = @dealership.cars
    @vendors = @dealership.vendors
  end

  def update
    authenticate_user!
    repair = Repair.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(repair.car_id)
    if repair.update_attributes(params[:repair])
      redirect_to dealership_car_path(dealership, @car)
    else
      flash.now[:errors] = repair.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    repair = Repair.find(params[:id])
    repair.destroy
    redirect_to root_path
  end



end

