class LineItem < ActiveRecord::Base
  #Decimos que la linea de producto pertenecerá a carrito y a producto.
  #También a orden de compra.
  belongs_to :order
  belongs_to :product
  belongs_to :cart

  #Definimos el precio total
  def total_price
    product.price * quantity
  end
end
