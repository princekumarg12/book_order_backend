class Api::V1::UsersController < ApplicationController
  before_action :authorize_request

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user, serializer: UserSerializer
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end

  private

  # def user_params
  #   params.require(:user).permit(:name, :relative_type, :relative_name, :mobile, :gender)
  # end
  def user_params
    params.require(:user).permit(
        :name, :relative_type, :relative_name, :mobile, :gender,
        addresses_attributes: [
            :house_no, :landmark, :village, :post_office, :tehsil, :district, :state, :city, :pin_code, :address_type, :is_primary
        ]
    )
  end
end
