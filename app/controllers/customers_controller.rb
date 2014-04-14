class CustomersController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @potential_customers = Customer.where(dealership_id: @dealership.id, status: "Potential Customer")
    @existing_customers = Customer.where(dealership_id: @dealership.id, status: "Existing Customer")
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:id])
    @conversations = @customer.conversations.order(:date).reverse
    @deals = Deal.find_all_by_customer_id(@customer.id)
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:customer] ? @customer = Customer.new(flash[:customer]) : @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    dealership = Dealership.find(params[:dealership_id])
    @customer.dealership_id = dealership.id
    @customer.status = "Potential Customer"
    if @customer.save
      redirect_to dealership_customer_path(dealership, @customer)
    else
      flash[:errors] = @customer.errors.full_messages
      flash[:customer] = params[:customer]
      redirect_to new_dealership_customer_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:id])
    @fields = flash[:customer] if flash[:customer]
  end

  def update
    customer = Customer.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if customer.update_attributes(params[:customer])
      redirect_to dealership_customer_path(dealership, customer)
    else
      flash[:errors] = customer.errors.full_messages
      flash[:customer] = params[:customer]
      redirect_to edit_dealership_customer_path(dealership, customer)
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    deal = Deal.find_by_customer_id(customer.id)
    dealership = Dealership.find(params[:dealership_id])
    if deal
      car = Car.find(deal.car_id)
      car.status = "Frontline"
      car.save
      deal.destroy
    end
    customer.destroy
    redirect_to dealership_customers_path(dealership)
  end
end
