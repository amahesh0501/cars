class CardsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?, :is_dealership_admin?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @cards = @dealership.cards
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @card = Card.find(params[:id])
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
    @expenses = Expense.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => @card.id})
    @repairs = Repair.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => @card.id})
    @paychecks = Paycheck.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => @card.id})
    @purchases = Purchase.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => @card.id})
    @transactions = @expenses + @repairs + @paychecks + @purchases
    @transactions = @transactions.sort_by &:date
    @transactions = @transactions.reverse
    @payments = @card.payments.sort_by &:date
    @payments = @payments.reverse
    @total = 0
    @transactions.each {|transaction| @total += transaction.amount if transaction.amount}
    @payments_total = 0
    @payments.each {|payment| @payments_total += payment.amount if payment.amount}
    @outstanding_balance = @total - @payments_total

  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:card] ? @card = Card.new(flash[:card]) : @card = Card.new
  end

  def create
    @card = Card.new(params[:card])
    dealership = Dealership.find(params[:dealership_id])
    @card.dealership_id = dealership.id
    if @card.save
      redirect_to dealership_card_path(dealership, @card)
    else
      flash[:errors] = @card.errors.full_messages
      flash[:card] = params[:card]
      redirect_to new_dealership_card_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @card = Card.find(params[:id])
    @fields = flash[:card] if flash[:card]
  end

  def update
    card = Card.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if card.update_attributes(params[:card])
      redirect_to dealership_card_path(dealership, card)
    else
      flash[:errors] = card.errors.full_messages
      flash[:card] = params[:card]
      redirect_to edit_dealership_card_path(dealership, card)
    end
  end

  def destroy
    card = Card.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    @expenses = Expense.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => card.id})
    @repairs = Repair.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => card.id})
    @paychecks = Paycheck.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => card.id})
    @purchases = Purchase.find(:all, :conditions => {:dealership_id => params[:dealership_id], :card_id => card.id})
    @transactions = @expenses + @repairs + @paychecks + @purchases
    @transactions.each do |transaction|
      transaction.card_id = nil
      transaction.payment_method = "Other"
      transaction.save
    end
    card.destroy
    redirect_to dealership_cards_path(dealership)
  end



end

