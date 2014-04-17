class CarsController < ApplicationController

   before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @cars = @dealership.cars
    @sold_cars = Car.where(dealership_id: @dealership.id, status: "Sold")
    @frontline_cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @repair_cars = Car.where(dealership_id: @dealership.id, status: "Needs Repairs")
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(params[:id])
    @repairs = Repair.where(car_id: @car.id)
    @car_repair_expenses = 0
    @repairs.each {|repair| @car_repair_expenses += repair.amount}
    @total_price = @car.acquire_price + @car_repair_expenses if @car.acquire_price
    @purchase_price = 0
    @deal = Deal.find_by_car_id(@car.id)
    @purchase_price = @deal.amount if @deal
    @profit = @purchase_price - @total_price if @purchase_price && @total_price
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:car] ? @car = Car.new(flash[:car]) : @car = Car.new
  end

  def new_with_vin
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.new
    details = @car.vin_lookup(params[:vin])
    @vin = details[0]
    @make = details[1]
    @model = details[2]
    @year = details[3]
    @trim = details[4]
    @engine = details[5]

  end

  def create
    @car = Car.new(params[:car])
    dealership = Dealership.find(params[:dealership_id])
    @car.make_model_year = "#{@car.year} #{@car.make} #{@car.model}"
    @car.dealership_id = dealership.id
    if @car.save
      purchase = Purchase.new
      purchase.name = @car.make_model_year
      purchase.amount = params[:car][:acquire_price]
      purchase.date = params[:car][:acquire_date]
      purchase.location = params[:car][:acquire_location]
      purchase.car_id = @car.id
      purchase.dealership_id = dealership.id
      purchase.save
      redirect_to dealership_car_path(dealership, @car)
    else
      flash[:errors] = @car.errors.full_messages
      flash[:car] = params[:car]
      redirect_to new_dealership_car_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(params[:id])
    @fields = flash[:car] if flash[:car]

  end

  def update
    car = Car.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    car.make_model_year = "#{car.year} #{car.make} #{car.model}"
    if car.update_attributes(params[:car])
      purchase = Purchase.find_by_car_id(car.id)
      purchase.name = car.make_model_year
      purchase.amount = params[:car][:acquire_price]
      purchase.date = params[:car][:acquire_date]
      purchase.location = params[:car][:acquire_location]
      purchase.car_id = car.id
      purchase.dealership_id = dealership.id
      purchase.save
      redirect_to dealership_car_path(dealership, car)
    else
      flash[:errors] = car.errors.full_messages
      flash[:car] = params[:car]
      redirect_to edit_dealership_car_path(dealership, car)
    end
  end

  def destroy
    car = Car.find(params[:id])
    deal = Deal.find_by_car_id(car.id)
    dealership = Dealership.find(params[:dealership_id])
    if deal
      customer = Customer.find(deal.customer_id)
      customer.status = "Potential Customer"
      customer.save
      deal.destroy
    end
    car.destroy
    redirect_to dealership_cars_path(dealership)
  end



end

