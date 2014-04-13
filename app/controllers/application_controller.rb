class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_admin?
    redirect_to root_path unless current_user.site_admin == true
  end

  def dealership_active?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id)
    redirect_to inactive_path if dealership.active == false
  end

  def is_member?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id)
    redirect_to blocked_path unless dealership.id == params[:dealership_id].to_i
  end

  def is_dealership_admin?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id)
    redirect_to blocked_path unless dealership.id = params[:dealership_id] && membership.is_dealership_admin == true
  end



end
