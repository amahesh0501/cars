class CarsController < ApplicationController

   before_filter :authenticate_user!, :dealership_active?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @cars = @dealership.cars
    @sold_cars = Car.where(dealership_id: @dealership.id, status: "Sold")
    @frontline_cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @repair_cars = Car.where(dealership_id: @dealership.id, status: "Needs Repairs")
    floored_repair_cars = Car.where(dealership_id: @dealership.id, status: "Needs Repairs", flooring: true)
    floored_frontline_cars = Car.where(dealership_id: @dealership.id, status: "Frontline", flooring: true)
    @floored_cars = floored_frontline_cars + floored_repair_cars
    @floored_cars = @floored_cars.sort_by &:acquire_date

    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @car = Car.find(params[:id])
    @auction = Auction.find(@car.auction_id) if @car.auction_id
    @floorer = Floorer.find(@car.floorer_id) if @car.floorer_id
    @repairs = Repair.where(car_id: @car.id)
    @car_repair_expenses = 0
    @repairs.each {|repair| @car_repair_expenses += repair.amount}
    @car.other_costs ? @other_costs = @car.other_costs : @other_costs = 0
    @car.advertising_cost ? @advertising_cost = @car.advertising_cost : @advertising_cost = 0
    @car.frontend_pac ? @frontend_pac = @car.frontend_pac : @frontend_pac = 0
    @commissions = Commission.find_all_by_car_id(@car.id) #if Commission.find_by_car_id(@car.id)
    @commission = 0
    @commissions.each {|commission| @commission = @commission + commission.amount}
    @commission ? @commission_amount = @commission : @commission_amount = 0
    @total_price = @car.acquire_price + @car_repair_expenses + @other_costs + @advertising_cost + @frontend_pac + @commission_amount if @car.acquire_price

    @purchase_price = 0
    @temps = @car.temps
    @deal = Deal.find_by_car_id(@car.id)
    if @deal
      @amount_financed = @deal.amount + (@deal.amount * @deal.sales_tax_percent/100) + @deal.smog_fee + @deal.doc_fee + @deal.reg_fee + @deal.other_fee + @deal.gap_price + @deal.warranty_price
    end

    @purchase_price = @deal.amount if @deal
    @profit = @purchase_price - @total_price if @purchase_price && @total_price
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
    @days_on_lot = (Date.today - @car.acquire_date).to_i if @car.status == "Frontline" || @car.status == "Needs Repairs"
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:car] ? @car = Car.new(flash[:car]) : @car = Car.new
    @no_vin_lookup = true if flash[:errors]
    @auctions = @dealership.auctions
    @floorers = @dealership.floorers
    @cards = @dealership.cards
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
    @transmission = details[5]
    @body_style = details[6]
    @interior_color = details[7]
    @exterior_color = details[8]
    @engine = details[9]
    @wheel_base = details[10]
    @auctions = @dealership.auctions
    @floorers = @dealership.floorers
    @cards = @dealership.cards

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
      purchase.payment_method = params[:car][:payment_method]
      purchase.check_number = params[:car][:check_number]
      purchase.card_id = params[:car][:card_id]
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
    @auctions = @dealership.auctions
    @floorers = @dealership.floorers
    @fields = flash[:car] if flash[:car]
    @cards = @dealership.cards
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
      purchase.payment_method = params[:car][:payment_method]
      purchase.check_number = params[:car][:check_number]
      purchase.card_id = params[:car][:card_id]
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

