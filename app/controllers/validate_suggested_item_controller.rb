class ValidateSuggestedItemController < ApplicationController
  def index
  		item = []
		if params[:item_description].present?
			item_description = params[:item_description]
			condition = "unaccent(lower(description || ' ' || brands.name)) = '#{I18n.transliterate(item_description.downcase)}'"
			item = Item.joins(:brand).where(condition)
		end
		if !item.empty?
			if !item.first.stocks.empty?
				result = [valid: true, id: item.first.id, price: item.first.price_default, discount: item.first.discount, my_prices: item.first.my_prices, stock_current:item.first.get_total_stock, notice: 'Transacción exitosa' ]
			else
				result = [valid: false, id: 0, notice: '¡EL produccto selecionado no existe en nuestro stocks realice una orden de compra por favor.!']
			end				
		else
			result = [valid: false, id: 0, notice: '¡No existe el Producto en nuestros almacenes.!']
		end
		render json: result
  end
   def purchase_item_suggested
  		item = []
		if params[:item_description].present?
			item_description = params[:item_description]
			condition = "unaccent(lower(description || ' ' || brands.name)) = '#{I18n.transliterate(item_description.downcase)}'"
			item = Item.joins(:brand).where(condition)
		end
		if !item.empty?
			result = [valid: true, id: item.first.id, price: item.first.price, discount: item.first.discount]
		else
			result = [valid: false, id: 0]
		end
		render json: result
  end
 
end
  
