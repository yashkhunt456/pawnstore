class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items

  enum :status, { pending: 0, completed: 1 }

  def add_product(product_id, quantity = 1)
    existing_item = order_items.find_by(product_id: product_id)
    if existing_item
      existing_item.increment!(:quantity, quantity)
    else
      order_items.create(product_id: product_id, quantity: quantity)
    end
  end

end
