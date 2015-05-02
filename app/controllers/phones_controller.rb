class PhonesController < ApplicationController

  before_action :get_phone_by_id, only: [:show, :update, :destroy]
  before_action :get_phone_by_phoneid, only: [:ping, :files]
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
    if @phone.update(phone_params)
      render json: @phone, status: 200, location: venue_phone_url(Venue.find(params[:venue_id]), @phone)
    else
      render json: @phone.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @phone.destroy
    head :no_content
  end

  def ping
    render json: { response: 'ACK', phone: @phone  }, status: :ok
  end

  def files
    files = @phone.get_urls
    render json: {files: files}, status: :ok
  end

  private

  def phone_params
    params.require(:phone).permit(:wifiSSID, :wifiPassword, :venue_id)
  end

  def get_phone_by_id
    @phone = Phone.find(params[:id])
  end

  def get_phone_by_phoneid
    @phone = Phone.find(params[:phone_id])
  end

end







