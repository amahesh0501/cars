class FloorersController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    redirect_to root_path

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @floorer = Floorer.find(params[:id])
    @vehicles = @floorer.cars
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:floorer] ? @floorer = Floorer.new(flash[:floorer]) : @floorer = Floorer.new
    @us_states = us_states
  end

  def create
    @floorer = Floorer.new(params[:floorer])
    dealership = Dealership.find(params[:dealership_id])
    @floorer.dealership_id = dealership.id
    @floorer.address = "#{params[:floorer][:address_line_1]} #{params[:floorer][:address_line_2]} #{params[:floorer][:address_city]}, #{params[:floorer][:address_state]} #{params[:floorer][:address_zip]}"
    if @floorer.save
      dealership.floorers << @floorer
      redirect_to dealership_floorer_path(dealership, @floorer)
    else
      flash[:errors] = @floorer.errors.full_messages
      flash[:floorer] = params[:floorer]
      redirect_to new_dealership_floorer_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @floorer = Floorer.find(params[:id])
    @fields = flash[:floorer] if flash[:floorer]
    @us_states = us_states
  end

  def update
    floorer = Floorer.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    floorer.address = "#{params[:floorer][:address_line_1]} #{params[:floorer][:address_line_2]} #{params[:floorer][:address_city]}, #{params[:floorer][:address_state]} #{params[:floorer][:address_zip]}"
    if floorer.update_attributes(params[:floorer])
      redirect_to dealership_floorer_path(dealership, floorer)
    else
      flash[:errors] = floorer.errors.full_messages
      flash[:floorer] = params[:floorer]
      redirect_to edit_dealership_floorer_path(dealership, floorer)
    end
  end

  def destroy
    floorer = Floorer.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    floorer.destroy
    redirect_to dealership_floorers_path(dealership)
  end



end