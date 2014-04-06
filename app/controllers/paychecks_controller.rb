class PaychecksController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    paycheck = Paycheck.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    employee = Employee.find(paycheck.employee_id)
    redirect_to dealership_employee_path(dealership, employee)
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @paycheck = Paycheck.new
    @employees = @dealership.employees
  end

  def create
    authenticate_user!
    @paycheck = Paycheck.new(params[:paycheck])
    dealership = Dealership.find(params[:dealership_id])
    employee = Employee.find(@paycheck.employee_id)
    if @paycheck.save
      dealership.paychecks << @paycheck
      redirect_to dealership_employee_path(dealership, employee)
    else
      flash.now[:errors] = @paycheck.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @paycheck = Paycheck.find(params[:id])
    @employees = @dealership.employees
  end

  def update
    authenticate_user!
    paycheck = Paycheck.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    employee = Employee.find(paycheck.employee_id)
    if paycheck.update_attributes(params[:paycheck])
      redirect_to dealership_employee_path(dealership, employee)
    else
      flash.now[:errors] = paycheck.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    paycheck = Paycheck.find(params[:id])
    paycheck.destroy
    redirect_to root_path
  end



end

