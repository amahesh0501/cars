class TempsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @temps = @dealership.temps.order(:date).reverse
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @temp = Temp.find(params[:id])
    @customer = Customer.find(@temp.customer_id) if @temp.customer_id
    @employee = Employee.find(@temp.employee_id) if @temp.employee_id
    @car = Car.find(@temp.car_id)

    @gap = Gap.find(@temp.gap_id) if @temp.gap_id
    @lender = Lender.find(@temp.lender_id) if @temp.lender_id
    @warranty = Warranty.find(@temp.warranty_id) if @temp.warranty_id

    @temp.amount ?  @sales_price = @temp.amount : @sales_price = 0
    @temp.down_payment ?  @down_payment = @temp.down_payment : @down_payment = 0
    @temp.term ?  @term = @temp.term : @term = 1
    @temp.apr ?  @apr = @temp.apr : @apr = 0
    @temp.trade_in_value ?  @trade_in_value = @temp.trade_in_value : @trade_in_value = 0
    @temp.sales_tax_amount ?  @sales_tax_amount = @temp.sales_tax_amount : @sales_tax_amount = 0


    @final_price = @sales_price + @sales_tax_amount - @down_payment - @trade_in_value
    @monthly_payment = @final_price / @term
  end

  def new
    flash[:temp] ? @temp = Temp.new(flash[:temp]) : @temp = Temp.new
    @dealership = Dealership.find(params[:dealership_id])
    @employees = @dealership.employees.order('name ASC')
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @customers = @dealership.customers.order('name ASC')
    @gaps = @dealership.gaps
    @warranties = @dealership.warranties
    @lenders = @dealership.lenders

  end

  def create
    @temp = Temp.new(params[:temp])
    @dealership = Dealership.find(params[:dealership_id])
    @temp.dealership_id = @dealership.id
    @temp.sales_tax_amount = @temp.amount * (@temp.sales_tax_percent / 100)
    if @temp.save
      redirect_to dealership_temp_path(@dealership, @temp)
    else
      flash[:errors] = @temp.errors.full_messages
      flash[:temp] = params[:temp]
      redirect_to new_dealership_temp_path(@dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @temp = Temp.find(params[:id])
    @employees = @dealership.employees
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @customers = @dealership.customers
    @gaps = @dealership.gaps
    @warranties = @dealership.warranties
    @lenders = @dealership.lenders
    @fields = flash[:temp] if flash[:temp]
  end

  def update
    @temp = Temp.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])
    @temp.sales_tax_amount = @temp.amount * (@temp.sales_tax_percent / 100)
    if @temp.update_attributes(params[:temp])
      redirect_to dealership_temp_path(@dealership, @temp)
    else
      flash[:errors] = @temp.errors.full_messages
      flash[:temp] = params[:temp]
      redirect_to edit_dealership_temp_path(@dealership, @temp)
    end
  end

  def destroy
    temp = Temp.find(params[:id])
    temp.destroy
    redirect_to root_path
  end

end