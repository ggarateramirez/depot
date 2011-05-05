class Order < ActiveRecord::Base
  #Tiene varias lineas de items
  has_many :line_items, :dependent => :destroy

  #Definimos métodos de pago para la orden.
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

  #Validaciones formulario de orden.
  validates :name, :address, :email, :pay_type, :presence => true
  validates :pay_type, :inclusion => PAYMENT_TYPES

  #Definimos método de añadir a la orden lineas de pedido del carrito.
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil #Para prevenir que no venga de un carrito destruido.
      line_items << item
    end
  end
end
