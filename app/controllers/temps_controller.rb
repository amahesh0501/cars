class TempsController < ApplicationController

  # before_filter :authenticate_user!, :dealership_active?, :is_member?

  def index
    @dealership = Dealership.find(params[:dealership_id])
    @temps = @dealership.temps.order(:date).reverse
  end

  def show
    @dealership = Dealership.find(params[:dealership_id])
    @temp = Temp.find(params[:id])
    @customer = Customer.find(@temp.customer_id) if @temp.customer_id
    @employee = Employee.find(@temp.employee_id) if @temp.employee_id
    @car = Car.find(@temp.car_id) if @temp.car_id
    @gap = Gap.find(@temp.gap_id) if @temp.gap_id
    @lender = Lender.find(@temp.lender_id) if @temp.lender_id
    @warranty = Warranty.find(@temp.warranty_id) if @temp.warranty_id

    @employees = @dealership.employees.order('name ASC')
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @customers = @dealership.customers.order('name ASC')


    @amount_financed = @temp.amount + (@temp.amount * @temp.sales_tax_percent/100) + @temp.smog_fee + @temp.doc_fee + @temp.reg_fee + @temp.other_fee + @temp.gap_price + @temp.warranty_price + @temp.trade_in_value - @temp.down_payment - @temp.less_payoff
    interest = @temp.apr  * 0.01 if @temp.apr
    interest ? @interest_charge = @amount_financed * interest : @interest_charge = 0
    @monthly_payment = (@amount_financed + @interest_charge) / @temp.term

    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    @dealership.sales_tax ? sales_tax_percent = @dealership.sales_tax : sales_tax_percent = 0

    temp = Temp.new(dealership_id: @dealership.id, date: Date.today, amount: 10000, term: 60, sales_tax_percent: sales_tax_percent, smog_fee: 0, doc_fee: 50, reg_fee: 50, gap_price: 0, warranty_price: 0, trade_in_value: 0, down_payment: 0, less_payoff: 0, apr: 0, other_fee: 0)
    temp.save
    redirect_to dealership_temp_path(@dealership, temp)



  end

  def create
    @temp = Temp.new(params[:temp])
    @dealership = Dealership.find(params[:dealership_id])
    @temp.dealership_id = @dealership.id
    @temp.sales_tax_amount = @temp.amount * (@temp.sales_tax_percent / 100)
    if @temp.save
      redirect_to dealership_temp_path(@dealership, @temp)
    else
      flash[:errors] = @temp.errors.full_messages
      flash[:temp] = params[:temp]
      redirect_to new_dealership_temp_path(@dealership)
    end
  end

  def edit
    @dealership = Dealership.find(params[:dealership_id])
    @temp = Temp.find(params[:id])
    redirect_to dealership_temp_path(@dealership, @temp)
  end

  def update
    @temp = Temp.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])
    @temp.sales_tax_amount = @temp.amount * (@temp.sales_tax_percent / 100)
    if @temp.update_attributes(params[:temp])
      redirect_to dealership_temp_path(@dealership, @temp)
    else
      flash[:errors] = @temp.errors.full_messages
      flash[:temp] = params[:temp]
      redirect_to dealership_temp_path(@dealership, @temp)
    end
  end

  def destroy
    dealership = Dealership.find(params[:dealership_id])
    temp = Temp.find(params[:id])
    temp.destroy
    redirect_to dealership_deals_path(dealership)
  end

  def convert
    temp = Temp.find(params[:id])
    @dealership = Dealership.find(1)
    flash[:deal] = {employee_id: temp.employee_id, car_id: temp.car_id, customer_id: temp.customer_id, dealership_id: temp.dealership_id, warranty_id: temp.warranty_id, gap_id: temp.gap_id, lender_id: temp.lender_id, amount: temp.amount, sales_tax_percent: temp.sales_tax_percent, sales_tax_amount: temp.sales_tax_amount, date: temp.date, down_payment: temp.down_payment, apr: temp.apr, term: temp.term, trade_in_value: temp.trade_in_value, less_payoff: temp.less_payoff, days_to_first_payment: temp.days_to_first_payment, deffered_down_1_payment: temp.deffered_down_1_payment, deffered_down_1_date: temp.deffered_down_1_date, smog_fee: temp.smog_fee, doc_fee: temp.doc_fee, reg_fee: temp.reg_fee, warranty_term: temp.warranty_term, warranty_cost: temp.warranty_cost, warranty_price: temp.warranty_price, warranty_type: temp.warranty_type, gap_term: temp.gap_term, gap_cost: temp.gap_cost, gap_price: temp.gap_price, discount_fee: temp.discount_fee}
      p temp
        p "*"  * 100
        p flash[:deal]

    redirect_to new_dealership_deal_path(@dealership)
  end

end