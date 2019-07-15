class SalesController < ApplicationController
   before_action :set_sale, only: [:create, :show, :edit, :update, :destroy]
   before_action :set_combo_values, only: [:new, :edit, :update, :create]
    PAGE_SIZE = 10
    load_and_authorize_resource
  # GET /sales
  # GET /sales.json
  def index
    unsaved_sales = Sale.where(state: "draft", user: current_user)
    unsaved_sales.each do |sale|
    sale.destroy
    end

    unsaved_clients = Client.where(state: "draft", user_id: current_user.id)
    unsaved_clients.each do |client|
    client.destroy
    end
    @page = (params[:page] || 0).to_i
    @keywords = params[:keywords]

    search = Search.new(@page, PAGE_SIZE, @keywords, current_user)
    @sales, @number_of_pages = search.sales
  end

  # GET /sales/1
  # GET /sales/1.json
  def show

  end

  # GET /sales/new
  def new 
    unsaved_sales = Sale.where(state: "draft", user: current_user)
    unsaved_sales.each do |sale|
      # se debe obtimisar el codigo se esta repidiendo muchas veses
      # sale.sale_details.each do |sale_details|        
      #   movements = sale_details.movements
      #   movements.each do |movement|
      #   stock = Stock.find(movement.stock_id)
      #   stock.qty_out -= movement.qty_out
      #   stock.state = 'disponible'
      #   stock.save
      #   movement.destroy
      #   end
      #   sale_details.destroy
      # end
    sale.destroy_sale_details_all
    sale.destroy
    end
    last_sale = Sale.where(state: "confirmed", user: current_user).maximum('number')
    number =  (last_sale != nil) ? last_sale + 1 : 1
    @sale = Sale.create(date: Date::current, number: number, state: "draft", user: current_user, client_id: params[:client], credit_expiration: Date::current)
    @sale.sale_details.build
    params[:sale_id] = @sale.id.to_s
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create

  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
     @sale.update(sale_params)
      if @sale.is_can_sale       
          @sale.confirmed! 
                        
    respond_to do |format|
          if @sale.update(sale_params)
            format.html { redirect_to sales_url, notice: 'Venta actualizada.'}
            format.json { render :show, status: :ok, location: @sale }
          else
            format.html { render :edit }
            format.json { render json: @sale.errors, status: :unprocessable_entity }
          end
      end
    else
      respond_to do |format|        
        format.html { redirect_to new_sale_path(client: @sale.client.id), alert: '¡Venta no realizada usted supero el limite de creito que dispone.!' }
      end
    end
  end
  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy_sale_details_all
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Venta eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
        @sale = Sale.find(params[:id])
    end
   def set_combo_values

   @clients = Client.where(state: 1, asig_a_user_id: current_user.id).order(:name)
   end
    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      # params.require(:sale).permit(:number, :date, :state, :user_id)
        params.require(:sale).permit(:number, :date, :client_id, :credit, :credit_expiration, :discount, sale_details_attributes: [:id, :sale_id, :item_id, :number, :qty, :price, :price_list_id, :_destroy] )
    end
end



