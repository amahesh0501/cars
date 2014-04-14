class ConversationsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    redirect_to dealership_customer_path(Dealership.find(params[:dealership_id]), Customer.find(params[:customer_id]))
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @conversation = Conversation.find(params[:id])
    @expenses = Expense.where(conversation_id: @conversation.id)
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:customer_id])
    @employees = @dealership.employees
    flash[:conversation] ? @conversation = Conversation.new(flash[:conversation]) : @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(params[:conversation])
    dealership = Dealership.find(params[:dealership_id])
    customer = Customer.find(params[:customer_id])
    @conversation.dealership_id = dealership.id
    @conversation.customer_id = customer.id
    if @conversation.save
      redirect_to dealership_customer_path(dealership, customer)
    else
      flash[:errors] = @conversation.errors.full_messages
      flash[:conversation] = params[:conversation]
      redirect_to new_dealership_customer_conversation_path(dealership, customer)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:customer_id])
    @conversation = Conversation.find(params[:id])
     @employees = @dealership.employees
  end

  def update
    conversation = Conversation.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    customer = Customer.find(params[:customer_id])
    if conversation.update_attributes(params[:conversation])
      redirect_to dealership_customer_path(dealership, customer)
    else
      flash[:errors] = conversation.errors.full_messages
      flash[:conversation] = params[:conversation]
      redirect_to edit_dealership_customer_conversation_path(dealership, customer, conversation)
    end
  end

  def destroy
    conversation = Conversation.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:customer_id])
    conversation.destroy
    redirect_to dealership_customer_path(@dealership, @customer)
  end



end