class DealershipsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!

    @dealership = Dealership.find(params[:id])
    @cars = @dealership.cars
    @customers = @dealership.customers
    @memberships = Membership.where(dealership_id: @dealership.id)
    @deals = @dealership.deals
    @expenses = @dealership.expenses
    @membership = Membership.find_by_user_id_and_dealership_id(current_user.id, @dealership.id)
    if @membership
      if @membership.revoked?(@membership)
        render :revoked
      else
        render :show
      end
    else
      redirect_to new_dealership_membership_path(@dealership)
    end



  end

  def new
    authenticate_user!
    @dealership = Dealership.new
  end

  def create
    authenticate_user!
    @dealership = Dealership.new(params[:dealership])
    if @dealership.save
      Membership.create(user_id: current_user.id, dealership_id: @dealership.id)
      redirect_to root_path
    else
      flash.now[:errors] = @dealership.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:id])
  end

  def update
    authenticate_user!
    dealership = Dealership.find(params[:id])
    if dealership.update_attributes(params[:dealership])
      redirect_to dealership_path(dealership)
    else
      flash.now[:errors] = dealership.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    dealership = Dealership.find(params[:id])
    dealership.destroy
    redirect_to root_path
  end
end