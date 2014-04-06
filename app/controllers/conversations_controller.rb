class ConversationsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @conversation = Conversation.find(params[:id])
    @expenses = Expense.where(conversation_id: @conversation.id)
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:customer_id])
    @conversation = Conversation.new
     @employees = @dealership.employees
  end

  def create
    authenticate_user!
    @conversation = Conversation.new(params[:conversation])
    dealership = Dealership.find(params[:dealership_id])
    customer = Customer.find(params[:customer_id])
    if @conversation.save
      dealership.conversations << @conversation
      redirect_to dealership_customer_path(dealership, customer)
    else
      flash.now[:errors] = @conversation.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @customer = Customer.find(params[:customer_id])
    @conversation = Conversation.find(params[:id])
     @employees = @dealership.employees
  end

  def update
    authenticate_user!
    conversation = Conversation.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    customer = Customer.find(params[:customer_id])
    if conversation.update_attributes(params[:conversation])
      redirect_to dealership_customer_path(dealership, customer)
    else
      flash.now[:errors] = conversation.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    conversation = Conversation.find(params[:id])
    conversation.destroy
    redirect_to root_path
  end



end