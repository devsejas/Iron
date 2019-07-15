class ValidateSuggestedSaleController < ApplicationController
  def index
  			sale = []
		if params[:payment_sale].present?
			payment_sale = params[:payment_sale]

			sale = Sale.where(number: payment_sale, user_id: current_user.id)
		end
		if !sale.empty?
			result = [valid: true, id: sale.ids, ex: sale.first.client.name, dir: sale.first.client.address.get_direccion_all, saldo: sale.first.saldo]

		else
			result = [valid: false, id: 0]
		end
		render json: result
  end
end
