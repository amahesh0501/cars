class VendorsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @vendor = Vendor.find(params[:id])
    @expenses = Expense.where(vendor_id: @vendor.id)
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @vendor = Vendor.new
  end

  def create
    authenticate_user!
    @vendor = Vendor.new(params[:vendor])
    dealership = Dealership.find(params[:dealership_id])
    if @vendor.save
      dealership.vendors << @vendor
      redirect_to dealership_vendor_path(dealership, @vendor)
    else
      flash.now[:errors] = @vendor.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @vendor = Vendor.find(params[:id])
  end

  def update
    authenticate_user!
    vendor = Vendor.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if vendor.update_attributes(params[:vendor])
      redirect_to dealership_vendor_path(dealership, vendor)
    else
      flash.now[:errors] = vendor.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    vendor = Vendor.find(params[:id])
    vendor.destroy
    redirect_to root_path
  end



end