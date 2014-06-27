class MenusController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @menus = @dealership.menus
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @menu = Menu.find(params[:id])
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:menu] ? @menu = Menu.new(flash[:menu]) : @menu = Menu.new
  end

  def create
    @menu = Menu.new(params[:menu])
    dealership = Dealership.find(params[:dealership_id])
    @menu.dealership_id = dealership.id
    if @menu.save
      dealership.menus << @menu
      redirect_to dealership_menu_path(dealership, @menu)
    else
      flash[:errors] = @menu.errors.full_messages
      flash[:menu] = params[:menu]
      redirect_to new_dealership_menu_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @menu = Menu.find(params[:id])
    @fields = flash[:menu] if flash[:menu]
  end

  def update
    menu = Menu.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if menu.update_attributes(params[:menu])
      redirect_to dealership_menu_path(dealership, menu)
    else
      flash[:errors] = menu.errors.full_messages
      flash[:menu] = params[:menu]
      redirect_to edit_dealership_menu_path(dealership, menu)
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    menu.destroy
    redirect_to dealership_menus_path(dealership)
  end



end