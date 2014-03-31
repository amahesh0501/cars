class MembershipsController < ApplicationController

  def new
    @membership = Membership.new
    @user = current_user
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to dealership_path(@dealership) if Membership.find_by_user_id_and_dealership_id(current_user.id, @dealership.id)
  end

  def create
    dealership = Dealership.find(params[:dealership_id])
    Membership.create(user_id: current_user.id, dealership_id: dealership.id) if dealership.grant_access(params[:access_code])
    redirect_to dealership_path(dealership)
  end

  def revoke
    @membership = Membership.where(user_id: params[:user_id], dealership_id: params[:dealership_id]).first
    if !@membership
      id = nil
    else
      id = @membership.user_id
      @membership.revoked = true
      @membership.save
    end
    render json: {user_id: id}.to_json
  end

  # def reinstate
  #   @membership = Membership.where(user_id: params[:user_id], dealership_id: params[:dealership_id]).first
  #   if !@membership
  #     id = nil
  #   else
  #     id = @membership.user_id
  #     @membership.revoked = false
  #     @membership.save
  #   end
  #   render json: {user_id: id}.to_json
  # end

  # def destroy
  #   membership = Membership.find(params[:id])
  #   membership.destroy
  #   render json: {dealership_id: params[:dealership_id], user_id: current_user.id}.to_json
  # end

end