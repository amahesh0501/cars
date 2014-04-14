class DealsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @deals = @dealership.deals.order(:date).reverse
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @customer = Customer.find(@deal.customer_id)
    @employee = Employee.find(@deal.employee_id)
    @car = Car.find(@deal.car_id)
  end

  def new
    flash[:deal] ? @deal = Deal.new(flash[:deal]) : @deal = Deal.new
    @dealership = Dealership.find(params[:dealership_id])
    @employees = @dealership.employees
    @cars = @dealership.cars
    @customers = @dealership.customers
  end

  def create
    @deal = Deal.new(params[:deal])
    @dealership = Dealership.find(params[:dealership_id])
    @deal.dealership_id = @dealership.id
    if @deal.save
      @car = Car.find(@deal.car_id)
      @car.status = "Sold"
      @car.save
      @customer = Customer.find(@deal.customer_id)
      @customer.status = "Existing Customer"
      @customer.save
      redirect_to dealership_deal_path(@dealership, @deal)
    else
      flash[:errors] = @deal.errors.full_messages
      flash[:deal] = params[:deal]
      redirect_to new_dealership_deal_path(@dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @employees = @dealership.employees
    @cars = @dealership.cars
    @customers = @dealership.customers
    @fields = flash[:deal] if flash[:deal]
  end

  def update
    @deal = Deal.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])
    if @deal.update_attributes(params[:deal])
      redirect_to dealership_deal_path(@dealership, @deal)
    else
      flash[:errors] = @deal.errors.full_messages
      flash[:deal] = params[:deal]
      redirect_to edit_dealership_deal_path(@dealership, @deal)
    end
  end

  def destroy
    deal = Deal.find(params[:id])
    car = Car.find(deal.car_id)
    car.status = "Frontline"
    car.save
    customer = Customer.find(deal.customer_id)
    if customer.deals.length == 1
      customer.status = "Potential Customer"
      customer.save
    end
    deal.destroy
    redirect_to root_path
  end


end