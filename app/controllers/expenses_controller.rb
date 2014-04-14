class ExpensesController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
     if params[:start_date]
       @expenses = Expense.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @repairs = Repair.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @paychecks = Paycheck.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @purchases = Purchase.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @deals = Deal.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })
       @revenues = Revenue.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}" })

       @transactions = @expenses + @repairs + @paychecks + @purchases
       @gains = @deals + @revenues

       @expense_total = 0
       @transactions.each {|transaction| @expense_total += transaction.amount if transaction.amount}

       @revenue_total = 0
       @gains.each {|gain| @revenue_total += gain.amount if gain.amount}

       @profit = @revenue_total - @expense_total

     else
      @expenses = Expense.find_all_by_dealership_id(params[:dealership_id])
      @repairs = Repair.find_all_by_dealership_id(params[:dealership_id])
      @paychecks = Paycheck.find_all_by_dealership_id(params[:dealership_id])
      @purchases = Purchase.find_all_by_dealership_id(params[:dealership_id])
      @deals = Deal.find_all_by_dealership_id(params[:dealership_id])
      @revenues = Revenue.find_all_by_dealership_id(params[:dealership_id])

      @transactions = @expenses + @repairs + @paychecks + @purchases
      @gains = @deals + @revenues

      @expense_total = 0
      @transactions.each {|transaction| @expense_total += transaction.amount if transaction.amount}

      @revenue_total = 0
      @gains.each {|gain| @revenue_total += gain.amount if gain.amount}

      @profit = @revenue_total - @expense_total
     end


     @dealership = Dealership.find(params[:dealership_id])
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:expense] ? @expense = Expense.new(flash[:expense]) : @expense = Expense.new
    @vendors = @dealership.vendors
  end

  def create
    @expense = Expense.new(params[:expense])
    dealership = Dealership.find(params[:dealership_id])
    @expense.dealership_id = dealership.id
    if @expense.save
      redirect_to dealership_expenses_path(dealership)
    else
      flash[:errors] = @expense.errors.full_messages
      flash[:expense] = params[:expense]
      redirect_to new_dealership_expense_path(dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
    @vendors = @dealership.vendors
    @fields = flash[:expense] if flash[:expense]
  end

  def update
    expense = Expense.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    if expense.update_attributes(params[:expense])
      redirect_to dealership_expense_path(dealership, expense)
    else
      flash[:errors] = expense.errors.full_messages
      flash[:expense] = params[:expense]
      redirect_to edit_dealership_expense_path(dealership, expense)
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    dealership = Dealership.find(params[:dealership_id])
    expense.destroy
    redirect_to dealership_expenses_path(dealership)
  end

  def get_dates

    dealership = Dealership.find(params[:dealership_id])
    redirect_to dealership_expenses_path(dealership, :start_date => params[:start_date], :end_date => params[:end_date])
    #render partial: 'expenses/expense_list', :locals => {:@expenses => expenses}
  end



end

