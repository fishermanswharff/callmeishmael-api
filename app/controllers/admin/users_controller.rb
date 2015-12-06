class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create, :destroy]

  def login
    user = User.find_by(email: params[:email])
    if user = user.authenticate(params[:password])
      render json: user, status: :accepted
    else
      head :unauthorized
    end
  end

  def logout
    head :ok
  end

  def resetpassword
    if params['email']
      @user = User.find_by(email: params['email'])
      UserMailer.reset_email(@user).deliver_now unless Rails.env.test?
    else
      head :unauthorized
    end
  end

  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.greeter_email(@user).deliver_now unless Rails.env.test?
      render json: @user, status: :created, location: admin_user_url(@user)
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :username, :phonenumber, :role, :email, :password, :password_confirmation, :active, :main_store_contact, :main_business_contact, :confirmed)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
