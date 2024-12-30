class Api::V1::OrdersController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      user = User.create!(user_params)

      address = user.addresses.create!(address_params)
      order = user.orders.create!(address: address)

      order_items_params.each do |item_params|
        order.order_items.create!(item_params)
      end

      render json: { message: 'Order created successfully!' }, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def user_params
    params.require(:user).permit(
        :name, :relative_type, :relative_name, :mobile, :gender, :password, :role
    )
  end

  def address_params
    params.require(:address).permit(
        :house_no, :landmark, :village, :post_office, :tehsil, :district, :state,
        :city, :pin_code, :address_type, :is_primary
    )
  end

  def order_items_params
    params.require(:order_items).map do |item|
      item.permit(:book_id, :quantity)
    end
  end

end
