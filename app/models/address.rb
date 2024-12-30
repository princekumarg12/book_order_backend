class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  # validates :house_no, :post_office, :district, :state, :city, :pin_code, presence: true
  validates :pin_code, format: { with: /\A\d{6}\z/, message: "must be a 6-digit number" }
end
