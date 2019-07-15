class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :set_combo_values, only: [:new, :edit, :update, :create]

  load_and_authorize_resource :except => [:cliente_sale]
  PAGE_SIZE = 5
  # GET /clients
  # GET /clients.json
  def index
  @page = (params[:page] || 0).to_i
    @keywords = params[:keywords]

    search = Search.new(@page, PAGE_SIZE, @keywords, current_user)
    @clients, @number_of_pages = search.clients_by_name
  end
  def myclients
    @myclients = Client.where(asig_a_user_id: current_user.id);
    
  end
  def cliente_sale
      client = []
      if params[:client_id].present?
        client_id = params[:client_id]
        client = Client.where(id: client_id)
      end

      if !client.empty?
        result = [valid: true, discount: client.first.discount, limit_credit: client.first.credit_limit,
        address: client.first.address.get_direccion_all, telf: client.first.phones, price_list_id: client.first.price_list_id, line_credit_available: client.first.line_credit_available ]
      else
        result = [valid: false, discount: 0 ,limit_credit: 0,
        address: "", telf: "" ]
      end
      render json: result
  end
  # GET /clients/1
  # GET /clients/1.json
  def show
     @user_asig = User.find(@client.asig_a_user_id)
  end

  # GET /clients/new
  def new
    @client = Client.new
     @addresses = []
    # @address= Address.new
  end

  # GET /clients/1/edit
  def edit
    @addresses = Address.where(id: @client.address_id)
    @user_asig = User.find(@client.asig_a_user_id)
  end

  # POST /clients
  # POST /clients.json
  def create
    @addresses = []
    @client = Client.new(client_params)
    @client.state = 1
    @client.saldo = 0
    @client.user_id = current_user.id
    @client.asig_a_user_id = current_user.id
    respond_to do |format|
      if @client.save

        format.html { redirect_to clients_url, notice: 'Client was successfully created.', flash: {success: 'Pattern Created Successfully'} }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_url, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    if @client.sales.count.equal? 0 and @client.contacts.count.equal? 0
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Cliente eliminado satisfactoriamente.' }
      format.json { head :no_content }
    end
  else
    respond_to do |format|
      format.html { redirect_to clients_url, alert: 'El cliente tiene actividades registradas no se puede eliminar.' }
      format.json { head :no_content }
     end
    end
  end

  private
  def set_combo_values

    @price_lists = PriceList.all
    @users = User.all

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :address_id, :phone, :mobile, :email, :web_site, :photo, :saldo , :discount, :credit_limit, :price_list_id, :asig_a_user_id )
    end
end


