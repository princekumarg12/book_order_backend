class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, numericality: {greater_than_or_equal_to: 1}
  validate :check_single_order_item_limit

  private

  def check_single_order_item_limit
    # If the user is not allowed to have multiple order items, check the order item count
    if order.user && !order.user.can_order_multiple_books? && order.order_items.count > 0
      errors.add(:base, "You can only have one order item.")
    end
  end
end
