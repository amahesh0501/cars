class FormsController < ApplicationController

   before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @forms = @dealership.forms
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @form = Form.find(params[:id])
    redirect_to dealership_forms_path
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    @form = Form.new
  end

  def create
    @form = Form.new(params[:form])
    dealership = Dealership.find(params[:dealership_id])
    @form.dealership_id = dealership.id
    if @form.save
      redirect_to dealership_forms_path(dealership, @form)
    else
    flash[:errors] = @form.errors.full_messages
    redirect_to new_dealership_form_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @form = Form.find(params[:id])
    @fields = flash[:form] if flash[:form]

  end

  def update
    form = Form.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if form.update_attributes(params[:form])
      redirect_to dealership_form_path(dealership, form)
    else
      flash[:errors] = form.errors.full_messages
      flash[:form] = params[:form]
      redirect_to edit_dealership_form_path(dealership, form)
    end
  end

  def destroy
    form = Form.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    form.destroy
    redirect_to dealership_forms_path(dealership)
  end



end

