class Product < ActiveRecord::Base

  #Vista por defecto ordenado por título:
  default_scope :order => 'title'
  #Tiene varias lineas de items
  has_many :line_items
  #Tiene varias ordenes que apuntan a lines de items
  has_many :orders, :through => :line_items
  #Antes de destruir asegurarse de que no hace referencia a una linea de item.
  before_destroy :ensure_not_referenced_by_any_line_item

  #Validaciones:

  validates :title, :description, :image_url, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with    => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, :length => {:minimum => 10}
  private

    # Definimos el Estar seguro de que no hay line items referenciados en ese producto.
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end