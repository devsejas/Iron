class BoxDetailsController < ApplicationController
  before_action :set_box_detail, only: [:show, :edit, :update, :destroy]

  # GET /box_details
  # GET /box_details.json
  def index
    @box_details = BoxDetail.all
  end

  # GET /box_details/1
  # GET /box_details/1.json
  def show
  end

  # GET /box_details/new
  def new
    @box_detail = BoxDetail.new
  end

  # GET /box_details/1/edit
  def edit
  end

  # POST /box_details
  # POST /box_details.json
  def create
    @box_detail = BoxDetail.new(box_detail_params)

    respond_to do |format|
      if @box_detail.save
        format.html { redirect_to @box_detail, notice: 'Box detail was successfully created.' }
        format.json { render :show, status: :created, location: @box_detail }
      else
        format.html { render :new }
        format.json { render json: @box_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /box_details/1
  # PATCH/PUT /box_details/1.json
  def update
    respond_to do |format|
      if @box_detail.update(box_detail_params)
        format.html { redirect_to @box_detail, notice: 'Box detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @box_detail }
      else
        format.html { render :edit }
        format.json { render json: @box_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /box_details/1
  # DELETE /box_details/1.json
  def destroy
    @box_detail.destroy
    respond_to do |format|
      format.html { redirect_to box_details_url, notice: 'Box detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box_detail
      @box_detail = BoxDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_detail_params
      params.require(:box_detail).permit(:box_id, :payment_id, :amount)
    end
end
