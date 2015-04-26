class VenuesController < ApplicationController

  before_action :set_venue, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create]

  def index
    venues = Venue.all
    render json: venues, status: :ok
  end

  def show
    render json: @venue, status: :ok
  end

  def create
    @venue = Venue.create(venue_params)
    if @venue.save
      render json: @venue, status: :created, location: venue_url(@venue)
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  def update
    if @venue.update(venue_params)
      render json: @venue, status: :ok
    else
      render json: @venue.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @venue.destroy
    head :no_content
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :status, :number_phones, :user_id)
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def admin_only
    unless is_admin?(get_token)
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {
        error: 'You are not an admin'
        }, status: 403
    end
  end

  def get_token
    request.headers.env['HTTP_AUTHORIZATION'].gsub(/Token token=/, "")
  end

  def is_admin?(token)
    User.where(token: token)[0].admin?
  end
end