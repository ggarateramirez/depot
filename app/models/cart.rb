class Cart < ActiveRecord::Base
  #Decimos que un carrito podrá tener varias lineas de producto.
  has_many :line_items, :dependent => :destroy

  #Definimos el método add_product.
  def add_product(product_id)
    current_item = line_items.where(:product_id => product_id).first
    if current_item
      current_item.quantity += 1
    else
      current_item = LineItem.new(:product_id => product_id)
      line_items << current_item
    end
    current_item
  end

  #Definimos el método precio total.
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  #Definimos el método total items.
  def total_items
    line_items.sum(:quantity)
  end
end
