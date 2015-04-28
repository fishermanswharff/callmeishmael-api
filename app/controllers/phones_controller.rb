class PhonesController < ApplicationController

  before_action :set_phone, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create]

  def index
    venue = Venue.find(params[:venue_id])
    render json: venue.phones, status: :ok
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def phone_params
    params.require(:phone).permit(:wifiSSID, :wifiPassword, :venue_id)
  end

  def set_phone
    @phone = Phone.find(params[:id])
  end
end