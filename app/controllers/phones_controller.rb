class PhonesController < ApplicationController

  before_action :get_phone_by_id, only: [:show, :update, :destroy]
  before_action :get_phone_by_phoneid, only: [:ping, :files, :log]
  before_filter :admin_only, only: [:create]

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
    render json: files, status: :ok
  end

  def log
    phone = Phone.find(params[:phone_id])
    venue = Venue.find(params[:venue_id])
    log = Base64.decode64(params[:log])
    dir = FileUtils.mkdir_p("#{Rails.root}/log/venue_#{venue.id}/phone_#{phone.id}")

    FileUtils.cd(dir.first) do
      s = "%10.9f" % Time.now.to_f
      # convert back to Time with:
      # Time.at(s.to_i)
      output = File.open("#{s}_log.txt", "w")
      output.puts Base64.decode64(params[:log])
      output.close

      binding.pry

      file_stat = File::Stat.new(output)
      if File.stat(output).file? && file_stat.size? > 0
        render json: { path: File.realpath(output) }, status: :created
      else
        render json: { error: 'Something bad happened' }, status: :unprocessable_entity
      end
    end
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







