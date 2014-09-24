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

    @taxable_amount = @temp.taxable_amount
    if @temp.sales_tax_percent
      @amount_financed = @taxable_amount + (@taxable_amount * (@temp.sales_tax_percent/100)) 
    else
      @amount_financed = @taxable_amount
    end

    if @temp.apr
     @amount_with_interest = @amount_financed + (@amount_financed * (@temp.apr/100) )
     @final_amount = @amount_with_interest - @temp.down_payment
    else
      if @temp.down_payment
        @final_amount = @amount_financed - @temp.down_payment 
      else
        @final_amount = @amount_financed
      end
    end
    @monthly_payment = @final_amount / @temp.term if @temp.term


    if @car
      @repairs = Repair.where(car_id: @car.id)
      @car_repair_expenses = 0
      @repairs.each {|repair| @car_repair_expenses += repair.amount}
      @car.other_costs ? @other_costs = @car.other_costs : @other_costs = 0
      @car.advertising_cost ? @advertising_cost = @car.advertising_cost : @advertising_cost = 0
      @car.frontend_pac ? @frontend_pac = @car.frontend_pac : @frontend_pac = 0
      
      @frontend_recieved = @temp.amount + @temp.smog_fee + @temp.doc_fee + @temp.reg_fee+ @temp.other_fee + @temp.less_payoff
      @frontend_cost = @car.acquire_price + @car_repair_expenses + @car.other_costs + @car.advertising_cost + @temp.estimated_commission + @temp.discount_fee + @temp.trade_in_value
      @frontend_profit = @frontend_recieved - @frontend_cost 

      @backend_recieved = @temp.gap_price + @temp.warranty_price + @temp.accessory_price 
      @backend_cost = @temp.gap_cost + @temp.warranty_cost + @temp.accessory_cost 
      @gap_profit = @temp.gap_price - @temp.gap_cost
      @warranty_profit = @temp.warranty_price - @temp.warranty_cost
      @accessory_profit = @temp.accessory_price - @temp.accessory_cost
      @backend_profit = @backend_recieved - @backend_cost 

      @total_received = @frontend_recieved + @backend_recieved
      @total_cost = @frontend_cost + @backend_cost + @car.frontend_pac
      @total_profit = @total_received - @total_cost

    end


    is_dealership_admin_view? ? @is_admin = true : @is_admin = false
  end

  def new
    @dealership = Dealership.find(params[:dealership_id])
    @dealership.sales_tax ? sales_tax_percent = @dealership.sales_tax : sales_tax_percent = 0

    temp = Temp.new(dealership_id: @dealership.id, date: Date.today)
    temp.save
    redirect_to dealership_temp_path(@dealership, temp)



  end

  def create
    @temp = Temp.new(params[:temp])
    @dealership = Dealership.find(params[:dealership_id])
    @temp.dealership_id = @dealership.id
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
    @employees = @dealership.employees.order('name ASC')
    @cars = Car.where(dealership_id: @dealership.id, status: "Frontline")
    @customers = @dealership.customers.order('name ASC')
  end

  def update
    @temp = Temp.find(params[:id])
    @dealership = Dealership.find(params[:dealership_id])
    @temp.sales_tax_amount = @temp.amount * (@temp.sales_tax_percent / 100) if @temp.sales_tax_percent && @temp.amount
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
    flash[:deal] = {employee_id: temp.employee_id, car_id: temp.car_id, customer_id: temp.customer_id, dealership_id: temp.dealership_id, warranty_id: temp.warranty_id, gap_id: temp.gap_id, lender_id: temp.lender_id, amount: number_with_precision(temp.amount, :precision => 2), sales_tax_percent: temp.sales_tax_percent, sales_tax_amount: temp.sales_tax_amount, date: temp.date, down_payment: number_with_precision(temp.down_payment, :precision => 2), apr: temp.apr, term: temp.term, trade_in_value: temp.trade_in_value, less_payoff: temp.less_payoff, days_to_first_payment: temp.days_to_first_payment, deffered_down_1_payment: temp.deffered_down_1_payment, deffered_down_1_date: temp.deffered_down_1_date, smog_fee: temp.smog_fee, doc_fee: temp.doc_fee, reg_fee: temp.reg_fee, warranty_term: temp.warranty_term, warranty_cost: temp.warranty_cost, warranty_price: temp.warranty_price, warranty_type: temp.warranty_type, gap_term: temp.gap_term, gap_cost: temp.gap_cost, gap_price: temp.gap_price, discount_fee: temp.discount_fee}
      p temp
        p "*"  * 100
        p flash[:deal]

    redirect_to new_dealership_deal_path(@dealership)
  end

end