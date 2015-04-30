class PhonesController < ApplicationController

  before_action :set_phone, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create]

  def index
    venue = Venue.find(params[:venue_id])
    render json: venue.phones, status: :ok
  end

  def show
    render json: @phone, status: :ok
  end

  def create
    venue = Venue.find(params[:venue_id])
    phone = Phone.create(phone_params)
    if phone.save
      phone.venue = venue
      phone.set_unique_id
      render json: phone, status: :created, location: venue_phone_url(venue, phone)
    else
      render json: phone.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  def ping
    @phone = Phone.find(params[:phone_id])
    render json: { response: 'ACK', phone: @phone }, status: :ok
  end

  private

  def phone_params
    params.require(:phone).permit(:wifiSSID, :wifiPassword, :venue_id)
  end

  def set_phone
    @phone = Phone.find(params[:id])
  end
end