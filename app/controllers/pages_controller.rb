class PagesController < ApplicationController
  def index
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
end

