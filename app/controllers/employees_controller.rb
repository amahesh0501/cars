class EmployeesController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?, :is_dealership_admin?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @employees = @dealership.employees.order(:name)
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @employee = Employee.find(params[:id])
    @paychecks = Paycheck.where(employee_id: @employee.id).order(:date).reverse
    @deals = Deal.where(employee_id: @employee.id)
    @cars = []
    @deals.each {|deal| @cars << Car.find(deal.car_id)}
    @temps = @employee.temps
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:employee] ? @employee = Employee.new(flash[:employee]) : @employee = Employee.new
    @us_states = us_states

  end

  def create
    @employee = Employee.new(params[:employee])
    @dealership = Dealership.find(params[:dealership_id])
    @employee.dealership_id = @dealership.id
    @employee.address = "#{params[:employee][:address_line_1]} #{params[:employee][:address_line_2]} #{params[:employee][:address_city]}, #{params[:employee][:address_state]} #{params[:employee][:address_zip]}"
    if @employee.save
      redirect_to dealership_employee_path(@dealership, @employee)
    else
      flash[:errors] = @employee.errors.full_messages
      flash[:employee] = params[:employee]
      redirect_to new_dealership_employee_path(@dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @employee = Employee.find(params[:id])
    @fields = flash[:employee] if flash[:employee]
    @us_states = us_states
  end

  def update
    employee = Employee.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    employee.address = "#{params[:employee][:address_line_1]} #{params[:employee][:address_line_2]} #{params[:employee][:address_city]}, #{params[:employee][:address_state]} #{params[:employee][:address_zip]}"
    if employee.update_attributes(params[:employee])
      redirect_to dealership_employee_path(dealership, employee)
    else
      flash[:errors] = employee.errors.full_messages
      flash[:employee] = params[:employee]
      redirect_to edit_dealership_employee_path(dealership, employee)
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    deals = Deal.find_all_by_employee_id(employee.id)
    deals.each do |deal|
      deal.employee_id = nil
      deal.save
    end

    paychecks = Paycheck.find_all_by_employee_id(employee.id)
    paychecks.each do |paycheck|
      paycheck.employee_id = nil
      paycheck.save
    end

    employee.destroy
    redirect_to dealership_employees_path(dealership)
  end



end