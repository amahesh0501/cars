class ExpensesController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
    @dealership = Dealership.find(params[:dealership_id])

     if params[:start_date]
       @expenses = Expense.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}", :dealership_id => params[:dealership_id]}, :order => "date DESC" )
       @repairs = Repair.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}", :dealership_id => params[:dealership_id]}, :order => "date DESC" )
       @paychecks = Paycheck.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}", :dealership_id => params[:dealership_id]}, :order => "date DESC" )
       @purchases = Purchase.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}", :dealership_id => params[:dealership_id]}, :order => "date DESC" )
       @deals = Deal.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}"}, :order => "date DESC" )
       @revenues = Revenue.find(:all, :conditions => { :date => "#{params[:start_date]}".."#{params[:end_date]}", :dealership_id => params[:dealership_id]}, :order => "date DESC" )

      @misc_expense_total = 0
      @expenses.each {|expense| @misc_expense_total += expense.amount }
      @repair_total = 0
      @repairs.each {|repair| @repair_total += repair.amount }
      @paycheck_total = 0
      @paychecks.each {|paycheck| @paycheck_total += paycheck.amount }
      @purchase_total = 0
      @purchases.each {|purchase| @purchase_total += purchase.amount }
      @deal_total = 0
      @deals.each {|deal| @deal_total += deal.amount }
      @misc_revenue_total = 0
      @revenues.each {|revenue| @misc_revenue_total += revenue.amount }

       @transactions = @expenses + @repairs + @paychecks + @purchases

       @gains = @deals + @revenues

       @expense_total = 0
       @transactions.each {|transaction| @expense_total += transaction.amount if transaction.amount}

       @revenue_total = 0
       @gains.each {|gain| @revenue_total += gain.amount if gain.amount}

       @profit = @revenue_total - @expense_total

       @cash_total = 0
       @cash_transactions = @transactions.select { |transaction| transaction.payment_method == 'Cash' }
       @cash_transactions.each {|transaction| @cash_total += transaction.amount if transaction.amount}

       @check_total = 0
       @check_transactions = @transactions.select { |transaction| transaction.payment_method == 'Check' }
       @check_transactions.each {|transaction| @check_total += transaction.amount if transaction.amount}

       @card_total = 0
       @card_transactions = @transactions.select { |transaction| transaction.payment_method == 'Credit Card' }
       @card_transactions.each {|transaction| @card_total += transaction.amount if transaction.amount}

       @other_total = 0
       @other_transactions = @transactions.select { |transaction| transaction.payment_method == 'Other' }
       @other_transactions.each {|transaction| @other_total += transaction.amount if transaction.amount}

       @cards = @dealership.cards



     else
      @expenses = Expense.find_all_by_dealership_id(params[:dealership_id], :order => "date DESC" )
      @repairs = Repair.find_all_by_dealership_id(params[:dealership_id], :order => "date DESC" )
      @paychecks = Paycheck.find_all_by_dealership_id(params[:dealership_id], :order => "date DESC" )
      @purchases = Purchase.find_all_by_dealership_id(params[:dealership_id], :order => "date DESC" )
      @deals = Deal.find_all_by_dealership_id(params[:dealership_id], :order => "date DESC" )
      @revenues = Revenue.find_all_by_dealership_id(params[:dealership_id], :order => "date DESC" )

      @misc_expense_total = 0
      @expenses.each {|expense| @misc_expense_total += expense.amount }
      @repair_total = 0
      @repairs.each {|repair| @repair_total += repair.amount }
      @paycheck_total = 0
      @paychecks.each {|paycheck| @paycheck_total += paycheck.amount }
      @purchase_total = 0
      @purchases.each {|purchase| @purchase_total += purchase.amount }
      @deal_total = 0
      @deals.each {|deal| @deal_total += deal.amount }
      @misc_revenue_total = 0
      @revenues.each {|revenue| @misc_revenue_total += revenue.amount }

      @transactions = @expenses + @repairs + @paychecks + @purchases
      @gains = @deals + @revenues

      @expense_total = 0
      @transactions.each {|transaction| @expense_total += transaction.amount if transaction.amount}

      @revenue_total = 0
      @gains.each {|gain| @revenue_total += gain.amount if gain.amount}

      @profit = @revenue_total - @expense_total


      @cash_total = 0
      @cash_transactions = @transactions.select { |transaction| transaction.payment_method == 'Cash' }
      @cash_transactions.each {|transaction| @cash_total += transaction.amount if transaction.amount}

      @check_total = 0
      @check_transactions = @transactions.select { |transaction| transaction.payment_method == 'Check' }
      @check_transactions.each {|transaction| @check_total += transaction.amount if transaction.amount}

      @card_total = 0
      @card_transactions = @transactions.select { |transaction| transaction.payment_method == 'Credit Card' }
      @card_transactions.each {|transaction| @card_total += transaction.amount if transaction.amount}

      @other_total = 0
      @other_transactions = @transactions.select { |transaction| transaction.payment_method == 'Other' }
      @other_transactions.each {|transaction| @other_total += transaction.amount if transaction.amount}

      @cards = @dealership.cards

     end


     @dealership = Dealership.find(params[:dealership_id])
  end

  def show
    @membership = Membership.find_by_user_id(current_user.id)
    @dealership = Dealership.find(params[:dealership_id])
    @expense = Expense.find(params[:id])
    @vendor = Vendor.find(@expense.vendor_id) if @expense.vendor_id
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    flash[:expense] ? @expense = Expense.new(flash[:expense]) : @expense = Expense.new
    @vendors = @dealership.vendors
    @cards = @dealership.cards
  end

  def create
    @expense = Expense.new(params[:expense])
    dealership = Dealership.find(params[:dealership_id])
    @expense.dealership_id = dealership.id
    if @expense.save
      if params[:expense][:redirect] == "vendor" && @expense.vendor_id != nil
        vendor = Vendor.find(params[:expense][:vendor_id])
        redirect_to dealership_vendor_path(dealership, vendor)
      else
        redirect_to dealership_expense_path(dealership, @expense)

      end
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
    @cards = @dealership.cards
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

