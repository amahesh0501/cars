class LendersController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to parties_path(@dealership)

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @lender = Lender.find(params[:id])
    @deals = Deal.where(lender_id: @lender.id)
    @temps = @lender.temps
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:lender] ? @lender = Lender.new(flash[:lender]) : @lender = Lender.new
    @us_states = us_states
  end

  def create
    @lender = Lender.new(params[:lender])
    dealership = Dealership.find(params[:dealership_id])
    @lender.dealership_id = dealership.id
    @lender.address = "#{params[:lender][:address_line_1]} #{params[:lender][:address_line_2]} #{params[:lender][:address_city]}, #{params[:lender][:address_state]} #{params[:lender][:address_zip]}"
    if @lender.save
      dealership.lenders << @lender
      redirect_to dealership_lender_path(dealership, @lender)
    else
      flash[:errors] = @lender.errors.full_messages
      flash[:lender] = params[:lender]
      redirect_to new_dealership_lender_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @lender = Lender.find(params[:id])
    @fields = flash[:lender] if flash[:lender]
    @us_states = us_states
  end

  def update
    lender = Lender.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    lender.address = "#{params[:lender][:address_line_1]} #{params[:lender][:address_line_2]} #{params[:lender][:address_city]}, #{params[:lender][:address_state]} #{params[:lender][:address_zip]}"
    if lender.update_attributes(params[:lender])
      redirect_to dealership_lender_path(dealership, lender)
    else
      flash[:errors] = lender.errors.full_messages
      flash[:lender] = params[:lender]
      redirect_to edit_dealership_lender_path(dealership, lender)
    end
  end

  def destroy
    lender = Lender.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    lender.destroy
    redirect_to parties_path(dealership)
  end



end