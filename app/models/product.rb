class Product < ApplicationRecord
    has_many :order_items

    validates :name, :description, :price, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }
end
