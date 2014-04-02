class ExpensesController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
    @car = Car.find(@expense.car_id) if @expense.car_id != nil
    @user = User.find(@expense.user_id) if @expense.user_id != nil
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.new
    @users = []
    @memberships = Membership.where(dealership_id: @dealership.id)
    @memberships.each {|membership| @users << User.find(membership.user_id)}
    @vendors = @dealership.vendors
    @cars = @dealership.cars
  end

  def create
    authenticate_user!
    @expense = Expense.new(params[:expense])
    dealership = Dealership.find(params[:dealership_id])
    if @expense.save
      dealership.expenses << @expense
      redirect_to dealership_expense_path(dealership, @expense)
    else
      flash.now[:errors] = @expense.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
    @users = []
    @memberships = Membership.where(dealership_id: @dealership.id)
    @memberships.each {|membership| @users << User.find(membership.user_id)}

    @cars = @dealership.cars
  end

  def update
    authenticate_user!
    expense = Expense.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if expense.update_attributes(params[:expense])
      redirect_to dealership_expense_path(dealership, expense)
    else
      flash.now[:errors] = expense.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to root_path
  end



end

