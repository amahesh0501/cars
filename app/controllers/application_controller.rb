class ApplicationController < ActionController::Base
  protect_from_forgery

  def is_admin?
    redirect_to root_path unless current_user.site_admin == true
  end

  def dealership_active?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id) if membership
    redirect_to inactive_path if dealership.active == false if membership
  end

  def is_member?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id) if membership
    redirect_to blocked_path unless dealership.id == params[:dealership_id].to_i if membership
  end

  def is_member_for_dashboard?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id) if membership
    redirect_to blocked_path unless dealership.id == params[:id].to_i if membership
  end

  def is_dealership_admin?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id)
    redirect_to no_access_path(params[:dealership_id]) unless dealership.id = params[:dealership_id] && membership.is_dealership_admin == true
  end

  def is_dealership_admin_view?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id)
    if dealership.id = params[:dealership_id] && membership.is_dealership_admin == true
      true
    else
      false
    end
  end

  def is_dealership_admin_view_for_dashboard?
    membership = Membership.find_by_user_id(current_user.id)
    dealership = Dealership.find(membership.dealership_id)
    if dealership.id = params[:id] && membership.is_dealership_admin == true
      true
    else
      false
    end
  end



end
