class GapsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to parties_path(@dealership)

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @gap = Gap.find(params[:id])
    @deals = Deal.where(gap_id: @gap.id)
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:gap] ? @gap = Gap.new(flash[:gap]) : @gap = Gap.new
    @us_states = us_states
  end

  def create
    @gap = Gap.new(params[:gap])
    dealership = Dealership.find(params[:dealership_id])
    @gap.dealership_id = dealership.id
    @gap.address = "#{params[:gap][:address_line_1]} #{params[:gap][:address_line_2]} #{params[:gap][:address_city]}, #{params[:gap][:address_state]} #{params[:gap][:address_zip]}"
    if @gap.save
      dealership.gaps << @gap
      redirect_to dealership_gap_path(dealership, @gap)
    else
      flash[:errors] = @gap.errors.full_messages
      flash[:gap] = params[:gap]
      redirect_to new_dealership_gap_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @gap = Gap.find(params[:id])
    @fields = flash[:gap] if flash[:gap]
    @us_states = us_states
  end

  def update
    gap = Gap.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    gap.address = "#{params[:gap][:address_line_1]} #{params[:gap][:address_line_2]} #{params[:gap][:address_city]}, #{params[:gap][:address_state]} #{params[:gap][:address_zip]}"
    if gap.update_attributes(params[:gap])
      redirect_to dealership_gap_path(dealership, gap)
    else
      flash[:errors] = gap.errors.full_messages
      flash[:gap] = params[:gap]
      redirect_to edit_dealership_gap_path(dealership, gap)
    end
  end

  def destroy
    gap = Gap.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    gap.destroy
    redirect_to parties_path(dealership)
  end



end