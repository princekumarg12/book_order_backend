class AddAddressToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :address, foreign_key: true
  end
end