class EmployeesController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @employee = Employee.find(params[:id])
    @paychecks = Paycheck.where(employee_id: @employee.id)
    @deals = Deal.where(employee_id: @employee.id)
    @cars = []
    @deals.each {|deal| @cars << Car.find(deal.car_id)}
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @employee = Employee.new
  end

  def create
    authenticate_user!
    @employee = Employee.new(params[:employee])
    @dealership = Dealership.find(params[:dealership_id])
    if @employee.save
      @dealership.employees << @employee
      redirect_to dealership_employee_path(@dealership, @employee)
    else
      flash.now[:errors] = @employee.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @employee = Employee.find(params[:id])
  end

  def update
    authenticate_user!
    employee = Employee.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if employee.update_attributes(params[:employee])
      redirect_to dealership_employee_path(dealership, employee)
    else
      flash.now[:errors] = employee.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    employee = Employee.find(params[:id])
    deals = Deal.find_all_by_employee_id(employee.id)
    deals.each do |deal|
      deal.employee_id = nil
      deal.save
    end

    employee.destroy
    redirect_to root_path
  end



end