class RevenuesController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    redirect_to root_path
  end

  def show
    @membership = Membership.find_by_user_id(current_user.id)
    @dealership = Dealership.find(params[:dealership_id])
    @revenue = Revenue.find(params[:id])
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:revenue] ? @revenue = Revenue.new(flash[:revenue]) : @revenue = Revenue.new
  end

  def create
    @revenue = Revenue.new(params[:revenue])
    dealership = Dealership.find(params[:dealership_id])
    @revenue.dealership_id = dealership.id
    if @revenue.save
      dealership.revenues << @revenue
      redirect_to dealership_revenue_path(dealership, @revenue)
    else
      flash[:errors] = @revenue.errors.full_messages
      flash[:revenue] = params[:revenue]
      redirect_to new_dealership_revenue_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @revenue = Revenue.find(params[:id])
    @fields = flash[:revenue] if flash[:revenue]
  end

  def update
    revenue = Revenue.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if revenue.update_attributes(params[:revenue])
      redirect_to dealership_revenue_path(dealership, revenue)

    else
      flash[:errors] = revenue.errors.full_messages
      flash[:revenue] = params[:revenue]
      redirect_to edit_dealership_revenue_path(dealership, revenue)
    end
  end

  def destroy
    revenue = Revenue.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    revenue.destroy
    redirect_to dealership_expenses_path(dealership)
  end



end