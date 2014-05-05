class VendorsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to dealership_parthners_path(@dealership)

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @vendor = Vendor.find(params[:id])
    @expenses = Expense.where(vendor_id: @vendor.id)
    @repairs = Repair.where(vendor_id: @vendor.id)
    @vendor_transactions = @expenses + @repairs
    @transaction_count = @vendor_transactions.length
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:vendor] ? @vendor = Vendor.new(flash[:vendor]) : @vendor = Vendor.new
    @us_states = us_states
  end

  def create
    @vendor = Vendor.new(params[:vendor])
    dealership = Dealership.find(params[:dealership_id])
    @vendor.dealership_id = dealership.id
    @vendor.address = "#{params[:vendor][:address_line_1]} #{params[:vendor][:address_line_2]} #{params[:vendor][:address_city]}, #{params[:vendor][:address_state]} #{params[:vendor][:address_zip]}"
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
    @us_states = us_states
    @category = @vendor.category
  end

  def update
    vendor = Vendor.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    vendor.address = "#{params[:vendor][:address_line_1]} #{params[:vendor][:address_line_2]} #{params[:vendor][:address_city]}, #{params[:vendor][:address_state]} #{params[:vendor][:address_zip]}"
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
    dealership = Dealership.find(params[:dealership_id])
    vendor.destroy
    redirect_to dealership_vendors_path(dealership)
  end



end