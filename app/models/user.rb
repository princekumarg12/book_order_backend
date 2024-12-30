class User < ApplicationRecord
  ROLES = %W[regular admin bulk_buyer]
  has_secure_password
  has_many :addresses
  # has_many :books
  has_many :orders, dependent: :destroy
  accepts_nested_attributes_for :addresses
  validates :name, presence: true
  # validates :mobile, presence: true, format: {with: /\A\d{10}\z/, message: "must be a valid 10-digit mobile number"}
  # validates :role, inclusion: {in: ROLES}
  # validates :email, presence: true, uniqueness: true
  # validates :email, format: {ff:ff URI::MailTo::EMAIL_REGEXP}

  def can_order_multiple_books?
    role == "bulk_buyer"
  end
end
