class PagesController < ApplicationController
  def index
    authenticate_user!
    if current_user
      @membership = Membership.find_by_user_id(current_user.id)
      if @membership
        dealership = Dealership.find(@membership.dealership_id)
        redirect_to dealership_path(dealership)
      else
        render :instructions
      end
    end
  end

  def admin
    authenticate_user!
    is_admin?
    @dealerships = Dealership.all
  end

  def inactive
  end

  def blocked
  end

  def test
  end


end

