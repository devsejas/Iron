
class Item < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :brand
  belongs_to :unit
  belongs_to :category
  # belongs_to :warehouse
  has_many :sale_details, inverse_of: :item, dependent: :destroy
  has_many :sales, through: :sale_details

  has_many :purchase_order_lines, inverse_of: :item, dependent: :destroy
  has_many :purchase_orders, through: :purchase_order_lines

  has_many :inventory_items, inverse_of: :item, dependent: :destroy
  has_many :inventory, through: :inventory_items
  has_many :stocks

  has_many :presentations, inverse_of: :item, dependent: :destroy 
  has_many :units, through: :presentations

  has_many :prices, inverse_of: :item, dependent: :destroy
  has_many :price_lists, through: :prices

 validates :description, presence: true
 def item_description
  self.description + ( (self.brand != nil) ? ' ' + self.brand.name : '' )
 end

 def brand_name
  if self.brand
     self.brand.name
  else
   ''
  end
 end

 def get_total_stock   
      stocks = self.stocks
      totales = 0
      stocks.flat_map do |e|
        totales += e.total     
      end
        totales
 end

 def get_precio_last
    pol = self.purchase_order_lines.last
    
 end

 def price_default
  price_sale = 0
    prices = self.prices
     prices.each do |p| 
      if p.price_list.default
        price_sale = p.price_sale
      end
     end
   price_sale
 end


   def my_prices  
         @prices = self.prices.to_json
   end

   # def addstock(qty_sales)
   #  stocks = self.stocks
     
   # end

end
 
 