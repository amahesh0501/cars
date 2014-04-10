class DealershipsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    dealership_active?

    @dealership = Dealership.find(params[:id])
    @cars = @dealership.cars
    @sold_cars = Car.where(dealership_id: @dealership.id, status: "Sold")
    @frontline_cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @repair_cars = Car.where(dealership_id: @dealership.id, status: "Needs Repairs")
    @potential_customers = Customer.where(dealership_id: @dealership.id, status: "Potential Customer")
    @existing_customers = Customer.where(dealership_id: @dealership.id, status: "Existing Customer")
    @memberships = Membership.where(dealership_id: @dealership.id)
    @deals = @dealership.deals
    @expenses = @dealership.expenses
    @vendors = @dealership.vendors
    @employees = @dealership.employees
    @membership = Membership.find_by_user_id_and_dealership_id(current_user.id, @dealership.id)
    if @dealership.active == true
      if @membership
        if @membership.has_access == true
          render :show
        else
          render :revoked
        end
      else
        redirect_to new_dealership_membership_path(@dealership)
      end
    end



  end

  def new
    authenticate_user!
    is_admin?
    @dealership = Dealership.new
    @errors = flash[:errors]
  end

  def create
    authenticate_user!
    @dealership = Dealership.new(dealership_name: params[:dealership_name], dealership_address: params[:dealership_address])
    user = User.new(email: params[:email], password: params[:password])
    if user.save && @dealership.save
      membership = Membership.create(user_id: user.id, dealership_id: @dealership.id, has_access: true, is_dealership_admin: true, email_address: user.email)
      redirect_to admin_path
    else
      user.destroy if user
      @dealership.destroy if @dealership
      membership.destroy if membership
      flash[:errors] = @dealership.errors.full_messages + user.errors.full_messages + membership.errors.full_messages
      redirect_to new_dealership_path
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

  def approve_member
    membership = Membership.find(params[:membership_id])
    membership.has_access = true
    membership.save
    dealership = Dealership.find(membership.dealership_id)
    redirect_to dealership_memberships_path(dealership)
  end

  def revoke_member
    membership = Membership.find(params[:membership_id])
    membership.has_access = false
    membership.save
    dealership = Dealership.find(membership.dealership_id)
    redirect_to dealership_memberships_path(dealership)
  end

  def mark_inactive
    authenticate_user!
    is_admin?
    dealership = Dealership.find(params[:dealership_id])
    dealership.active = false
    dealership.save
    redirect_to admin_path
  end
  def mark_active
    authenticate_user!
    is_admin?
    dealership = Dealership.find(params[:dealership_id])
    dealership.active = true
    dealership.save
    redirect_to admin_path
  end


end