class PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]
  before_action :set_combo_values, only: [:new, :edit, :update, :create]
  load_and_authorize_resource
  # GET /prices
  # GET /prices.json
  def index
    @prices = Price.all
  end

  # GET /prices/1
  # GET /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = Price.new
    @price.item_id =  params[:item_id]
    purchase_order_lines = Item.find(params[:item_id]).purchase_order_lines
    pos = purchase_order_lines.where(state: 'recivido').or(purchase_order_lines.where(state: 'asignado'))
    if pos.count >0
       @price.price_purchase = pos.last.price_unit
       @check= true
     else
      @check= false
    end
    

  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices
  # POST /prices.json
  def create
    @price = Price.new(price_params)


      if @price.save
        @item = @price.item
       
      else
        
      end
    
  end
  def myprice
      price = []
    if params[:price_id].present?
      price_id = params[:price_id]

      price = Price.where(id: price_id)
    end
    if !price.empty?
      result = [valid: true, id: price.first.id, price_sale: price.first.price_sale]

    else
      result = [valid: false, id: 0]
    end
    render json: result
   
  end

  # PATCH/PUT /prices/1
  # PATCH/PUT /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to @price, notice: 'Price was successfully updated.' }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1
  # DELETE /prices/1.json
  def destroy
    @price.destroy
      @item = @price.item
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_combo_values
   @price_lists = PriceList.all.order(:name)
  
  end
    def set_price
      @price = Price.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:name, :price_purchase, :utility, :price_sale, :active, :item_id, :price_list_id)
    end
end
