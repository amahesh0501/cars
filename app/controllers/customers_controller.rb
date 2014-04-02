class CustomersController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:id])
    @conversations = @customer.conversations
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.new
  end

  def create
    authenticate_user!
    @customer = Customer.new(params[:customer])
    dealership = Dealership.find(params[:dealership_id])
    if @customer.save
      dealership.customers << @customer
      redirect_to dealership_customer_path(dealership, @customer)
    else
      flash.now[:errors] = @customer.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:id])
  end

  def update
    authenticate_user!
    customer = Customer.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if customer.update_attributes(params[:customer])
      redirect_to dealership_customer_path(dealership, customer)
    else
      flash.now[:errors] = customer.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    customer = Customer.find(params[:id])
    customer.destroy
    redirect_to root_path
  end
end
