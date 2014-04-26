class DealershipsController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    authenticate_user!
    dealership_active?
    authenticate_user!

    is_dealership_admin_view_for_dashboard? ? @is_admin = true : @is_admin = false

    #DEALER THINGS
    @dealership = Dealership.find(params[:id])
    @cars = @dealership.cars.limit(4)
    @sold_cars = Car.where(dealership_id: @dealership.id, status: "Sold").limit(4)
    @frontline_cars = Car.where(dealership_id: @dealership.id, status: "Frontline").limit(4)
    @repair_cars = Car.where(dealership_id: @dealership.id, status: "Needs Repairs").limit(4)
    @potential_customers = Customer.where(dealership_id: @dealership.id, status: "Potential Customer")
    @existing_customers = Customer.where(dealership_id: @dealership.id, status: "Existing Customer")
    @memberships = Membership.where(dealership_id: @dealership.id)
    @deals = @dealership.deals
    @expenses = @dealership.expenses
    @vendors = @dealership.vendors
    @employees = @dealership.employees
    @conversations = @dealership.conversations.order("date DESC").limit(5)
    @membership = Membership.find_by_user_id_and_dealership_id(current_user.id, @dealership.id)

    #FINANCIALS

    @expenses = Expense.find(:all, :conditions => { :date => 30.days.ago..Date.today}, :order => "date DESC", :order => "date DESC" )
    @repairs = Repair.find(:all, :conditions => { :date => 30.days.ago..Date.today}, :order => "date DESC", :order => "date DESC" )
    @paychecks = Paycheck.find(:all, :conditions => { :date => 30.days.ago..Date.today}, :order => "date DESC", :order => "date DESC" )
    @purchases = Purchase.find(:all, :conditions => { :date => 30.days.ago..Date.today}, :order => "date DESC", :order => "date DESC" )
    @act_deals = Deal.find(:all, :conditions => { :date => 30.days.ago..Date.today}, :order => "date DESC", :order => "date DESC" )
    @revenues = Revenue.find(:all, :conditions => { :date => 30.days.ago..Date.today}, :order => "date DESC", :order => "date DESC" )

    @misc_expense_total = 0
    @expenses.each {|expense| @misc_expense_total += expense.amount }
    @repair_total = 0
    @repairs.each {|repair| @repair_total += repair.amount }
    @paycheck_total = 0
    @paychecks.each {|paycheck| @paycheck_total += paycheck.amount }
    @purchase_total = 0
    @purchases.each {|purchase| @purchase_total += purchase.amount }
    @deal_total = 0
    @act_deals.each {|deal| @deal_total += deal.amount }
    @misc_revenue_total = 0
    @revenues.each {|revenue| @misc_revenue_total += revenue.amount }

    @transactions = @expenses + @repairs + @paychecks + @purchases
    @gains = @act_deals + @revenues
    @expense_total = 0
    @transactions.each {|transaction| @expense_total += transaction.amount if transaction.amount}
    @revenue_total = 0
    @gains.each {|gain| @revenue_total += gain.amount if gain.amount}
    @profit = @revenue_total - @expense_total


    #ACCESS
    if @dealership.active == true
      if @membership
        if @membership.has_access == true
          render :show
        else
          render :revoked
        end
      else
        redirect_to new_dealership_membership_path(@dealership)
      end
    end



  end

  def new
    authenticate_user!
    is_admin?
    @dealership = Dealership.new
    @errors = flash[:errors]
  end

  def create
    authenticate_user!
    @dealership = Dealership.new(dealership_name: params[:dealership_name], dealership_address: params[:dealership_address])
    user = User.new(email: params[:email], password: params[:password])
    if user.save && @dealership.save
      membership = Membership.create(user_id: user.id, dealership_id: @dealership.id, has_access: true, is_dealership_admin: true, email_address: user.email)
      redirect_to admin_path
    else
      user.destroy if user
      @dealership.destroy if @dealership
      membership.destroy if membership
      flash[:errors] = @dealership.errors.full_messages + user.errors.full_messages + membership.errors.full_messages
      redirect_to new_dealership_path
    end
  end

  def edit
    authenticate_user!
    @dealership = Dealership.find(params[:id])
  end

  def update
    authenticate_user!
    dealership = Dealership.find(params[:id])
    if dealership.update_attributes(params[:dealership])
      redirect_to dealership_path(dealership)
    else
      flash.now[:errors] = dealership.errors.full_messages
      erb :edit
    end
  end

  def destroy
    authenticate_user!
    dealership = Dealership.find(params[:id])
    dealership.destroy
    redirect_to root_path
  end

  def approve_member
    membership = Membership.find(params[:membership_id])
    membership.has_access = true
    membership.save
    dealership = Dealership.find(membership.dealership_id)
    redirect_to dealership_memberships_path(dealership)
  end

  def revoke_member
    membership = Membership.find(params[:membership_id])
    membership.has_access = false
    membership.save
    dealership = Dealership.find(membership.dealership_id)
    redirect_to dealership_memberships_path(dealership)
  end

  def mark_inactive
    authenticate_user!
    is_admin?
    dealership = Dealership.find(params[:dealership_id])
    dealership.active = false
    dealership.save
    redirect_to admin_path
  end
  def mark_active
    authenticate_user!
    is_admin?
    dealership = Dealership.find(params[:dealership_id])
    dealership.active = true
    dealership.save
    redirect_to admin_path
  end

  def conversations
    dealership = Dealership.find(params[:id])
    @conversations = dealership.conversations.order("date DESC")
  end

  def no_access
  end

  def search
    @membership = Membership.find_by_user_id(current_user.id)
    @dealership = Dealership.find(params[:id])
    @term = params[:search]
    @cars = Car.search(params[:search])
    @customers = Customer.search(params[:search])
    @employees = Employee.search(params[:search])
    @vendors = Vendor.search(params[:search])
    @conversations = Conversation.search(params[:search])
    @expenses = Expense.search(params[:search])
    @paychecks = Paycheck.search(params[:search])
    @repairs = Repair.search(params[:search])
    @revenues = Revenue.search(params[:search])


    @everything = @cars + @customers + @employees + @vendors + @conversations + @expenses + @paychecks + @repairs + @revenues
    @transactions = @expenses + @paychecks + @repairs + @revenues

  end


end