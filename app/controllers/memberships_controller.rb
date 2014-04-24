class MembershipsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?, :is_dealership_admin?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @has_access = Membership.where(dealership_id: @dealership.id, has_access: true)
    @no_access = Membership.where(dealership_id: @dealership.id, has_access: false)
  end

  def new
    @membership = Membership.new
    @user = current_user
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to dealership_path(@dealership) if Membership.find_by_user_id_and_dealership_id(current_user.id, @dealership.id)
  end

  def create
    dealership = Dealership.find(params[:dealership_id])
    membership = Membership.new(user_id: current_user.id, dealership_id: dealership.id, email_address: current_user.email)
    redirect_to dealership_path(dealership) if membership.save
  end


end