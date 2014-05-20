class WarrantiesController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to parties_path(@dealership)

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @warranty = Warranty.find(params[:id])
    @deals = Deal.where(warranty_id: @warranty.id)
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:warranty] ? @warranty = Warranty.new(flash[:warranty]) : @warranty = Warranty.new
    @us_states = us_states
  end

  def create
    @warranty = Warranty.new(params[:warranty])
    dealership = Dealership.find(params[:dealership_id])
    @warranty.dealership_id = dealership.id
    @warranty.address = "#{params[:warranty][:address_line_1]} #{params[:warranty][:address_line_2]} #{params[:warranty][:address_city]}, #{params[:warranty][:address_state]} #{params[:warranty][:address_zip]}"
    if @warranty.save
      dealership.warranties << @warranty
      redirect_to dealership_warranty_path(dealership, @warranty)
    else
      flash[:errors] = @warranty.errors.full_messages
      flash[:warranty] = params[:warranty]
      redirect_to new_dealership_warranty_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @warranty = Warranty.find(params[:id])
    @fields = flash[:warranty] if flash[:warranty]
    @us_states = us_states
  end

  def update
    warranty = Warranty.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    warranty.address = "#{params[:warranty][:address_line_1]} #{params[:warranty][:address_line_2]} #{params[:warranty][:address_city]}, #{params[:warranty][:address_state]} #{params[:warranty][:address_zip]}"
    if warranty.update_attributes(params[:warranty])
      redirect_to dealership_warranty_path(dealership, warranty)
    else
      flash[:errors] = warranty.errors.full_messages
      flash[:warranty] = params[:warranty]
      redirect_to edit_dealership_warranty_path(dealership, warranty)
    end
  end

  def destroy
    warranty = Warranty.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    warranty.destroy
    redirect_to parties_path(dealership)
  end



end