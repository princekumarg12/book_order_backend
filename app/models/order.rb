class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  validate :check_book_limit_for_user

  private

  def check_book_limit_for_user
    if user && !user.can_order_multiple_books? && user.orders.count > 0
      errors.add(:base, "You can only order one book.")
    end
  end
end
