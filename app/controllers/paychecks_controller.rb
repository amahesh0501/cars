class PaychecksController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    redirect_to root_path
  end

  def show
    paycheck = Paycheck.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    employee = Employee.find(paycheck.employee_id)
    redirect_to dealership_employee_path(dealership, employee)
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:paycheck] ? @paycheck = Paycheck.new(flash[:paycheck]) : @paycheck = Paycheck.new
    @employees = @dealership.employees
  end

  def create
    @paycheck = Paycheck.new(params[:paycheck])
    dealership = Dealership.find(params[:dealership_id])
    if @paycheck.employee_id
      employee = Employee.find(@paycheck.employee_id)
      @paycheck.name = employee.name
    end
    @paycheck.dealership_id = dealership.id
    if @paycheck.save
      redirect_to dealership_employee_path(dealership, employee)
    else
      flash[:errors] = @paycheck.errors.full_messages
      flash[:paycheck] = params[:paycheck]
      redirect_to new_dealership_paycheck_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @paycheck = Paycheck.find(params[:id])
    @employees = @dealership.employees
    @fields = flash[:paycheck] if flash[:paycheck]
  end

  def update
    paycheck = Paycheck.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    employee = Employee.find(paycheck.employee_id)
    if paycheck.update_attributes(params[:paycheck])
      redirect_to dealership_employee_path(dealership, employee)
    else
      flash[:errors] = paycheck.errors.full_messages
      flash[:paycheck] = params[:paycheck]
      redirect_to edit_dealership_paycheck_path(dealership, paycheck)
    end
  end

  def destroy
    paycheck = Paycheck.find(params[:id])
    paycheck.destroy
    redirect_to root_path
  end



end

