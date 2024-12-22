class User < ApplicationRecord
  has_many :addresses
  has_many :books

  validates :name, :mobile, :gender, presence: true
end
