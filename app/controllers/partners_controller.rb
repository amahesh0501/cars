class PartnersController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    redirect_to parties_path(@dealership)

  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @partner = Partner.find(params[:id])
    @expenses = Expense.where(partner_id: @partner.id)
    @transaction_count = @expenses.length
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:partner] ? @partner = Partner.new(flash[:partner]) : @partner = Partner.new
    @us_states = us_states
  end

  def create
    @partner = Partner.new(params[:partner])
    dealership = Dealership.find(params[:dealership_id])
    @partner.dealership_id = dealership.id
    @partner.address = "#{params[:partner][:address_line_1]} #{params[:partner][:address_line_2]} #{params[:partner][:address_city]}, #{params[:partner][:address_state]} #{params[:partner][:address_zip]}"
    if @partner.save
      dealership.partners << @partner
      redirect_to dealership_partner_path(dealership, @partner)
    else
      flash[:errors] = @partner.errors.full_messages
      flash[:partner] = params[:partner]
      redirect_to new_dealership_partner_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @partner = Partner.find(params[:id])
    @fields = flash[:partner] if flash[:partner]
    @us_states = us_states
  end

  def update
    partner = Partner.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    partner.address = "#{params[:partner][:address_line_1]} #{params[:partner][:address_line_2]} #{params[:partner][:address_city]}, #{params[:partner][:address_state]} #{params[:partner][:address_zip]}"
    if partner.update_attributes(params[:partner])
      redirect_to dealership_partner_path(dealership, partner)
    else
      flash[:errors] = partner.errors.full_messages
      flash[:partner] = params[:partner]
      redirect_to edit_dealership_partner_path(dealership, partner)
    end
  end

  def destroy
    partner = Partner.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    partner.destroy
    redirect_to parties_path(dealership)
  end



end