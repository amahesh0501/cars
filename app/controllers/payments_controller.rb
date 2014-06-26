class PaymentsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?, :is_dealership_admin?

  def new
    @dealership = Dealership.find(params[:dealership_id])
    @card = Card.find(params[:card_id])
    flash[:payment] ? @payment = Payment.new(flash[:payment]) : @payment = Payment.new
  end

  def create
    @payment = Payment.new(params[:payment])
    card = Card.find(params[:card_id])
    dealership = Dealership.find(params[:dealership_id])
    @payment.dealership_id = dealership.id
    @payment.card_id = card.id
    if @payment.save
      redirect_to dealership_card_path(dealership, card)
    else
      flash[:errors] = @payment.errors.full_messages
      flash[:payment] = params[:payment]
      redirect_to new_dealership_card_payment_path(dealership, card)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @card = Card.find(params[:card_id])
    @payment = Payment.find(params[:id])
    @fields = flash[:payment] if flash[:payment]
  end

  def update
    payment = Payment.find(params[:id])
    card = Card.find(params[:card_id])
    dealership = Dealership.find(params[:dealership_id])
    if payment.update_attributes(params[:payment])
      redirect_to dealership_card_path(dealership, card)
    else
      flash[:errors] = payment.errors.full_messages
      flash[:payment] = params[:payment]
      redirect_to edit_dealership_card_payment_path(dealership, card, payment)
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    card = Card.find(params[:card_id])
    dealership = Dealership.find(params[:dealership_id])
    payment.destroy
    redirect_to dealership_payments_path(dealership)
  end



end

