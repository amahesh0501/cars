class DealsController < ApplicationController


  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @customer = Customer.find(@deal.customer_id)
    unless @deal.employee_id != nil
      @employee = Employee.find(@deal.employee_id)
    end
    @car = Car.find(@deal.car_id)
  end

  def new
    authenticate_user!
    @deal = Deal.new
    @dealership = Dealership.find(params[:dealership_id])

    @employees = @dealership.employees

    @cars = @dealership.cars
    @customers = @dealership.customers
  end

  def create
    authenticate_user!
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
      flash.now[:errors] = @deal.errors.full_messages
      redirect_to new_dealership_deal_path(@dealership)
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])

    @employees = @dealership.employees

    @cars = @dealership.cars
    @customers = @dealership.customers

  end

  def update
    authenticate_user!
    @deal = Deal.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])

    if @deal.update_attributes(params[:deal])
      redirect_to dealership_deal_path(dealership, deal)
    else
      flash.now[:errors] = @deal.errors.full_messages
      redirect_to edit_dealership_deal_path(@dealership, @deal)
    end
  end

  def destroy
    authenticate_user!
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