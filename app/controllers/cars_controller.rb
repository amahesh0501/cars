class CarsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(params[:id])
    @expenses = Expense.where(car_id: @car.id)
    @car_expenses = 0
    @expenses.each {|expense| @car_expenses += expense.amount}
    @total_price = @car.acquire_price + @car_expenses if @car.acquire_price
    @purchase_price = 0
    @deal = Deal.find_by_car_id(@car.id)
    @purchase_price = @deal.purchase_price if @deal
    @profit = @purchase_price - @total_price if @purchase_price && @total_price
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.new
  end

  def create
    authenticate_user!
    @car = Car.new(params[:car])
    dealership = Dealership.find(params[:dealership_id])
    if @car.save
      dealership.cars << @car
      redirect_to dealership_car_path(dealership, @car)
    else
      flash.now[:errors] = @car.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(params[:id])
  end

  def update
    authenticate_user!
    car = Car.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if car.update_attributes(params[:car])
      redirect_to dealership_car_path(dealership, car)
    else
      flash.now[:errors] = car.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    car = Car.find(params[:id])
    car.destroy
    redirect_to root_path
  end



end

