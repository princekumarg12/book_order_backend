class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, numericality: {greater_than_or_equal_to: 1}
  validate :validate_order_restrictions

  private

  def validate_order_restrictions
    return unless order.user && !order.user.can_order_multiple_books?

    if order.order_items.exists? || quantity > 1
      errors.add(:base, "Regular users can only order one book with a quantity of 1.")
    end
  end
end
