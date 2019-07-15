class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [:create, :show, :edit, :update, :destroy]
  before_action :set_combo_values, only: [:new, :edit, :update, :create]
  load_and_authorize_resource
  PAGE_SIZE = 10
  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    # eliminando los pedidos de compra que no fueron confirmados
    unsaved_purchase_orders = PurchaseOrder.where(state: "draft", create_uid: current_user.id)
    unsaved_purchase_orders.each do |p_o|  
    
    p_o.destroy
    end
    unsaved_suppliers = Supplier.where(state: "draft", create_uid: current_user.id)
    unsaved_suppliers.each do |supplier|
    supplier.destroy
    end
    @page = (params[:page] || 0).to_i
    @keywords = params[:keywords]

    search = Search.new(@page, PAGE_SIZE, @keywords)
    @purchase_orders, @number_of_pages = search.purchase_order_by_name

  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show

  end

  # GET /purchase_orders/new
  def new
    country = Country.create(name: "draft")

    departamento = Departamento.create(name: "draft")
    province = Province.create(name: "draft")
    zona = Zona.create(name: "draft")
    avenida = Avenida.create(name: "draft")
    payment_term = PaymentTerm.create(name: "draft")
    address = Address.new

    address.departamento_id = departamento.id
    address.province_id = province.id
    address.zona_id = zona.id
    address.avenida_id = avenida.id
    address.country_id = country.id
    address.description = "draft"
    address.save


      supplier = Supplier.new
      supplier.name = "draft"
      supplier.nit = "0000"
      supplier.address_id = address.id
      supplier.state = 'draft'
      supplier.create_uid = current_user.id
      supplier.save
   

     @purchase_order = PurchaseOrder.new
     @purchase_order.supplier_id = supplier.id
     @purchase_order.state = 'draft'

     @purchase_order.create_uid = current_user.id
     @purchase_order.date_order  = Date::current
     @purchase_order.payment_term_id = payment_term.id
     @purchase_order.save
     @purchase_order.purchase_order_lines.build
     params[:purchase_oreder_id] = @purchase_order.id.to_s

      country.destroy
      departamento.destroy
      province.destroy
      zona.destroy
      avenida.destroy
      address.destroy
      payment_term.destroy

      # @purchase_order.supplier_id = Supplier.first.id
  end

  # GET /purchase_orders/1/edit
  def edit
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @purchase_order.state = 'borrador'
    respond_to do |format|
      if @purchase_order.save
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully created.' }
        format.json { render :show, status: :created, location: @purchase_order }
      else
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      @purchase_order.state = 'borrador'
      if @purchase_order.update(purchase_order_params)
        format.html { redirect_to @purchase_order, notice: 'Purchase order was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_order }
      else
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end
def set_combo_values
   @suppliers = Supplier.where(state: 'confirmed').order(:name)
   @payment_terms = PaymentTerm.where(active: true).order(:name)
   end
    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:name, :date_order, :supplier_id, :currency_id, :state, :note, :origen, :date_aroved, :date_planned, :amount_untaxed, :amount_tax, :amount_total, :payment_term_id, :create_uid, :company_id, purchase_order_lines_attributes:[:id, :name, :item_qty, :date_planned, :item_id, :price_unit, :price_tax, :company_id, :state, :qty_received, :purchase_order_id, :_destroy]  )
    end
end


