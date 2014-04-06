class ExpensesController < ApplicationController

  def index
     if params[:start_date]
       @expenses = Expense.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @repairs = Repair.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @paychecks = Paycheck.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @deals = Deal.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @transactions = @expenses + @repairs + @paychecks

       @expense_total = 0
       @transactions.each {|transaction| @expense_total += transaction.amount}

       @revenue_total = 0
       @deals.each {|deal| @revenue_total += deal.purchase_price}

       @profit = @revenue_total - @expense_total

     else
      @expenses = Expense.find_all_by_dealership_id(params[:dealership_id])
     end


     @dealership = Dealership.find(params[:dealership_id])
  end

  def show
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
  end

  def new
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.new
    @vendors = @dealership.vendors
  end

  def create
    authenticate_user!
    @expense = Expense.new(params[:expense])
    dealership = Dealership.find(params[:dealership_id])
    if @expense.save
      dealership.expenses << @expense
      redirect_to dealership_expense_path(dealership, @expense)
    else
      flash.now[:errors] = @expense.errors.full_messages
      render :new
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
    @vendors = @dealership.vendors
  end

  def update
    authenticate_user!
    expense = Expense.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if expense.update_attributes(params[:expense])
      redirect_to dealership_expense_path(dealership, expense)
    else
      flash.now[:errors] = expense.errors.full_messages
      render :edit
    end
  end

  def destroy
    authenticate_user!
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to root_path
  end

  def get_dates

    dealership = Dealership.find(params[:dealership_id])
    redirect_to dealership_expenses_path(dealership, :start_date => params[:start_date], :end_date => params[:end_date])
    #render partial: 'expenses/expense_list', :locals => {:@expenses => expenses}
  end



end

