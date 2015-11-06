class PhonesController < ApplicationController

  before_action :get_phone_by_id, only: [:show, :update, :destroy]
  before_action :get_phone_by_phoneid, only: [:ping, :files, :log, :md5_files, :call_the_phone]
  before_filter :admin_only, only: [:create, :update]

  def index
    if params[:venue_id]
      venue = Venue.find(params[:venue_id])
      render json: venue.phones, status: :ok
    else
      phones = Phone.all
      render json: phones, status: :ok
    end
  end

  def show
    render json: @phone, status: :ok
  end

  def create
    venue = Venue.find(params[:venue_id])
    phone = venue.phones.create(phone_params)
    if phone.save
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
    render json: files, status: :ok
  end

  def md5_files
    files = @phone.get_md5_urls
    render json: files, status: :ok
  end

  def log
    phone = Phone.find(params[:phone_id])
    venue = Venue.find(params[:venue_id])
    log = Base64.decode64(params[:log])
    phonelog = Phonelog.create!(log_content: log.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), phone: phone)
    if phonelog.save
      unless Rails.env == 'test'
        resp = @phone.send_log_file(log)
      end
      render json: phonelog, status: :created
    else
      render json: phonelog.errors, status: :unprocessable_entity
    end
    # render json: { path: resp[:bucket_url] + '/' + resp[:response].key }, status: :ok
  end

  def call_the_phone
    @phone.call_yourself
    # Phone.call_the_phone
  end

  private

  def phone_params
    params.require(:phone).permit(:wifiSSID, :wifiPassword, :status, :venue_id)
  end

  def get_phone_by_id
    @phone = Phone.find(params[:id])
  end

  def get_phone_by_phoneid
    @phone = Phone.find(params[:phone_id])
  end

end







