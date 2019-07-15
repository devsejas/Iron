class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :set_combo_values, only: [:new, :edit, :update, :create]
  load_and_authorize_resource
  # GET /payments
  # GET /payments.json
   PAGE_SIZE = 10
  def index
    @page = (params[:page] || 0).to_i
    @keywords = params[:keywords]

    search = Search.new(@page, PAGE_SIZE, @keywords)
    @payments, @number_of_pages = search.payments_by_num
      
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    last_payment = Payment.where(state: "confirmed").maximum('num_payment')
    number =  (last_payment != nil) ? last_payment + 1 : 1
    @payment.num_payment = number
    @ban = false
    if params[:current_sale_id].present?
    @payment.sale_id = params[:current_sale_id]
    @sale = Sale.find( @payment.sale_id)
    @ban = true
    else
     @ban = false
    
    end
   

  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    if @payment.save
      messagess = 'successesfull'  
      else
        errores = "errors"
      end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end
     def set_combo_values
      @methods = PaymentType.where(nethod: 'Efectivo')
      @accounts = Account.where(reconcile: "true")
      end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:sale_id, :payment_type_id, :rode, :num_payment, :discount, :account_id)
    end
end
