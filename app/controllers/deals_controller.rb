class DealsController < ApplicationController

  before_filter :authenticate_user!, :dealership_active?, :is_member?, :except => [:show_quick_calculations]
  before_filter :authenticate_user!, :dealership_active?, :is_member_for_dashboard?, :only => [:show_quick_calculations]

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @deals = @dealership.deals.order(:date).reverse
    @temps = @dealership.temps.order(:date).reverse
  end

  def show
    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @customer = Customer.find(@deal.customer_id)
    @employee = Employee.find(@deal.employee_id) if @deal.employee_id
    @car = Car.find(@deal.car_id)

    @gap = Gap.find(@deal.gap_id) if @deal.gap_id
    @lender = Lender.find(@deal.lender_id) if @deal.lender_id
    @warranty = Warranty.find(@deal.warranty_id) if @deal.warranty_id






   @amount_financed = @deal.amount + (@deal.amount * @deal.sales_tax_percent/100) + @deal.smog_fee + @deal.doc_fee + @deal.reg_fee+ @deal.other_fee + @deal.gap_price + @deal.warranty_price + @deal.trade_in_value - @deal.down_payment - @deal.less_payoff

   interest = @deal.apr  * 0.01 if @deal.apr
   interest ? @interest_charge = @amount_financed * interest : @interest_charge = 0
   @monthly_payment = (@amount_financed + @interest_charge) / @deal.term
  end

  def new
    flash[:deal] ? @deal = Deal.new(flash[:deal]) : @deal = Deal.new
    @dealership = Dealership.find(params[:dealership_id])
    @employees = @dealership.employees.order('name ASC')
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @customers = @dealership.customers.order('name ASC')
    @gaps = @dealership.gaps
    @warranties = @dealership.warranties
    @lenders = @dealership.lenders

  end

  def create
    @deal = Deal.new(params[:deal])
    @dealership = Dealership.find(params[:dealership_id])
    @deal.dealership_id = @dealership.id
    @deal.sales_tax_amount = @deal.amount * (@deal.sales_tax_percent / 100)
    if @deal.save
      @car = Car.find(@deal.car_id)
      @car.status = "Sold"
      @car.save
      @customer = Customer.find(@deal.customer_id)
      @customer.status = "Existing Customer"
      @customer.save
      redirect_to dealership_deal_path(@dealership, @deal)
    else
      flash[:errors] = @deal.errors.full_messages
      flash[:deal] = params[:deal]
      redirect_to new_dealership_deal_path(@dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @deal = Deal.find(params[:id])
    @employees = @dealership.employees
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @customers = @dealership.customers
    @gaps = @dealership.gaps
    @warranties = @dealership.warranties
    @lenders = @dealership.lenders
    @fields = flash[:deal] if flash[:deal]
  end

  def update
    @deal = Deal.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])
    @deal.sales_tax_amount = @deal.amount * (@deal.sales_tax_percent / 100)
    if @deal.update_attributes(params[:deal])
      redirect_to dealership_deal_path(@dealership, @deal)
    else
      flash[:errors] = @deal.errors.full_messages
      flash[:deal] = params[:deal]
      redirect_to edit_dealership_deal_path(@dealership, @deal)
    end
  end

  def destroy
    deal = Deal.find(params[:id])
    car = Car.find(deal.car_id)
    car.status = "Frontline"
    car.save
    customer = Customer.find(deal.customer_id)
    if customer.deals.length == 1
      customer.status = "Potential Customer"
      customer.save
    end
    deal.destroy
    redirect_to root_path
  end

  def quick_calculate
    dealership = Dealership.find(params[:dealership_id])
    params[:amount] ? sales_price = params[:amount].to_f : sales_price = 0
    params[:down_payment] ? down_payment = params[:down_payment].to_f : down_payment = 0
    params[:term] ? term = params[:term].to_i : term = 1
    term = 1 if term == 0
    params[:apr] ? apr = params[:apr].to_f : apr = 0
    params[:trade_in_value] ? trade_in_value = params[:trade_in_value].to_f : trade_in_value = 0
    if params[:sales_tax_percent] && sales_price
      sales_tax_percent = params[:sales_tax_percent].to_f
      sales_tax_amount = (sales_tax_percent * sales_price) / 100
    else
      sales_tax_amount = 0
      sales_tax_percent = 0
    end

    final_price = sales_price + sales_tax_amount - down_payment - trade_in_value
    monthly_payment = final_price / term

    redirect_to quick_calculate_results_path(dealership, monthly_payment: monthly_payment, sales_price: sales_price, sales_tax_amount: sales_tax_amount, sales_tax_percent: sales_tax_percent, down_payment: down_payment, term: term, apr: apr, trade_in_value: trade_in_value )

  end

  def show_quick_calculations
    @dealership = Dealership.find(params[:id])
    @monthly_payment = params[:monthly_payment]
    @sales_price = params[:sales_price]
    @sales_tax_amount = params[:sales_tax_amount]
    @sales_tax_percent = params[:sales_tax_percent]
    @down_payment = params[:down_payment]
    @term = params[:term]
    @apr = params[:apr]
    @trade_in_value = params[:trade_in_value]
  end


end