class AuctionsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    redirect_to root_path

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @auction = Auction.find(params[:id])
    @vehicles = @auction.cars
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:auction] ? @auction = Auction.new(flash[:auction]) : @auction = Auction.new
    @us_states = us_states
  end

  def create
    @auction = Auction.new(params[:auction])
    dealership = Dealership.find(params[:dealership_id])
    @auction.dealership_id = dealership.id
    @auction.address = "#{params[:auction][:address_line_1]} #{params[:auction][:address_line_2]} #{params[:auction][:address_city]}, #{params[:auction][:address_state]} #{params[:auction][:address_zip]}"
    if @auction.save
      dealership.auctions << @auction
      redirect_to dealership_auction_path(dealership, @auction)
    else
      flash[:errors] = @auction.errors.full_messages
      flash[:auction] = params[:auction]
      redirect_to new_dealership_auction_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @auction = Auction.find(params[:id])
    @fields = flash[:auction] if flash[:auction]
    @us_states = us_states
  end

  def update
    auction = Auction.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    auction.address = "#{params[:auction][:address_line_1]} #{params[:auction][:address_line_2]} #{params[:auction][:address_city]}, #{params[:auction][:address_state]} #{params[:auction][:address_zip]}"
    if auction.update_attributes(params[:auction])
      redirect_to dealership_auction_path(dealership, auction)
    else
      flash[:errors] = auction.errors.full_messages
      flash[:auction] = params[:auction]
      redirect_to edit_dealership_auction_path(dealership, auction)
    end
  end

  def destroy
    auction = Auction.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    auction.destroy
    redirect_to dealership_auctions_path(dealership)
  end



end