class User < ApplicationRecord
  has_secure_password
  has_many :addresses
  has_many :books
  accepts_nested_attributes_for :addresses
  validates :name, presence: true
  validates :mobile, presence: true, format: {with: /\A\d{10}\z/, message: "must be a valid 10-digit mobile number"}
  validates :email, presence: true, uniqueness: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
end
