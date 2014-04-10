class VendorsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @vendors = @dealership.vendors
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @vendor = Vendor.find(params[:id])
    @expenses = Expense.where(vendor_id: @vendor.id)
    @repairs = Repair.where(vendor_id: @vendor.id)
    @vendor_transactions = @expenses + @repairs
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:vendor] ? @vendor = Vendor.new(flash[:vendor]) : @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(params[:vendor])
    dealership = Dealership.find(params[:dealership_id])
    @vendor.dealership_id = dealership.id
    if @vendor.save
      dealership.vendors << @vendor
      redirect_to dealership_vendor_path(dealership, @vendor)
    else
      flash[:errors] = @vendor.errors.full_messages
      flash[:vendor] = params[:vendor]
      redirect_to new_dealership_vendor_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @vendor = Vendor.find(params[:id])
    @fields = flash[:vendor] if flash[:vendor]
  end

  def update
    vendor = Vendor.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if vendor.update_attributes(params[:vendor])
      redirect_to dealership_vendor_path(dealership, vendor)
    else
      flash[:errors] = vendor.errors.full_messages
      flash[:vendor] = params[:vendor]
      redirect_to edit_dealership_vendor_path(dealership, vendor)
    end
  end

  def destroy
    vendor = Vendor.find(params[:id])
    vendor.destroy
    redirect_to root_path
  end



end