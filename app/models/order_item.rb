class OrderItem < ApplicationRecord
  acts_as_paranoid
  belongs_to :order
  belongs_to :product_including_deleted, class_name: "Product", foreign_key: 'product_id', with_deleted: true

  validates :quantity, numericality: { greater_than: 0 }

  def total_price
    product.price * quantity
  end
end
