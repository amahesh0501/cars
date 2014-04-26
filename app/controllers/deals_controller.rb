class DealsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?, :except => [:show_quick_calculations]
  before_filter :authenticate_user!, :dealership_active?, :is_member_for_dashboard?, :only => [:show_quick_calculations]

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @deals = @dealership.deals.order(:date).reverse
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @customer = Customer.find(@deal.customer_id)
    @employee = Employee.find(@deal.employee_id) if @deal.employee_id
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

  def quick_calculate
    dealership = Dealership.find(params[:dealership_id])
    params[:amount] ? sales_price = params[:amount].to_f : sales_price = 0
    params[:sales_tax_amount] ? sales_tax = params[:sales_tax_amount].to_f : sales_tax = 0
    params[:down_payment] ? down_payment = params[:down_payment].to_f : down_payment = 0
    params[:term] ? term = params[:term].to_i : term = 1
    term = 1 if term == 0
    params[:apr] ? apr = params[:apr].to_f : apr = 0
    params[:trade_in_value] ? trade_in_value = params[:trade_in_value].to_f : trade_in_value = 0

    final_price = sales_price + sales_tax - down_payment - trade_in_value
    monthly_payment = final_price / term

    redirect_to quick_calculate_results_path(dealership, monthly_payment: monthly_payment, sales_price: sales_price, sales_tax: sales_tax, down_payment: down_payment, term: term, apr: apr, trade_in_value: trade_in_value )

  end

  def show_quick_calculations
    @dealership = Dealership.find(params[:id])
    @monthly_payment = params[:monthly_payment]
    @sales_price = params[:sales_price]
    @sales_tax = params[:sales_tax]
    @down_payment = params[:down_payment]
    @term = params[:term]
    @apr = params[:apr]
    @trade_in_value = params[:trade_in_value]
  end


end