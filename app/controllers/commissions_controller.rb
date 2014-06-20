class CommissionsController < ApplicationController

   before_filter :authenticate_user!, :dealership_active?

  def index
    redirect_to root_path
  end

  def show
   @commission = Commission.find(params[:id])
   @car = Car.find(@commission.car_id)
   @dealership = Dealership.find(params[:dealership_id])

   redirect_to dealership_car_path(@dealership, @car)


  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:commission] ? @commission = Commission.new(flash[:commission]) : @commission = Commission.new
    @employees = @dealership.employees
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")


  end


  def create
    @commission = Commission.new(params[:commission])
    dealership = Dealership.find(params[:dealership_id])
    @commission.dealership_id = dealership.id
    if @commission.save
      @car = Car.find(@commission.car_id)
      @employee = Employee.find(@commission.employee_id)
      p "x"*100
      p params
      redirect_to dealership_car_path(dealership, @car)
    else
      flash[:errors] = @commission.errors.full_messages
      flash[:commission] = params[:commission]
      redirect_to new_dealership_commission_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @commission = Commission.find(params[:id])
    @employees = @dealership.employees
    @front_line_cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @cars = []
    @front_line_cars.each {|car| @cars << car unless Commission.find_by_car_id(car.id)}
  end

  def update
    commission = Commission.find(params[:id])
    car = Car.find(commission.car_id)
    dealership = Dealership.find(params[:dealership_id])
    if commission.update_attributes(params[:commission])
      @car = Car.find(commission.car_id)
      @employee = Employee.find(commission.employee_id)
      redirect_to dealership_car_path(dealership, @car)
    
    else
      flash[:errors] = commission.errors.full_messages
      flash[:commission] = params[:commission]
      redirect_to edit_dealership_commission_path(dealership, commission)
    end
  end

  def destroy
    dealership = Dealership.find(params[:dealership_id])
    commission = Commission.find(params[:id])
    car = Car.find(commission.car_id)
    employee = Employee.find(commission.employee_id)
    commission.destroy

    redirect_to dealership_car_path(dealership, car)
    
  end



end

