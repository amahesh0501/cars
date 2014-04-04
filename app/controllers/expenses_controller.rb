class ExpensesController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.new
    @vendors = @dealership.vendors
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
    @vendors = @dealership.vendors
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

