class CombineItemsInCart < ActiveRecord::Migration
  def self.up
    # reemplaza multiples items por un solo producto en un carro con un solo item
    Cart.all.each do |cart|
      # cuenta el número de cada producto que hay en el carro
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # quita items individuales
          cart.line_items.where(:product_id=>product_id).delete_all

          # reemplaza con un solo item
          cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end
      end
    end
  end


  def self.down
    # Separa items con cantidad>1 dentro de multiples items
    LineItem.where("quantity>1").each do |lineitem|
      # Añade un item individual
      lineitem.quantity.times do
        LineItem.create :cart_id=>lineitem.cart_id,
          :product_id=>lineitem.product_id, :quantity=>1
      end

    # Quita item original
    lineitem.destroy
    end
  end
end
