class VenuesController < ApplicationController

  before_action :set_venue, only: [:show, :update, :destroy]

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
      render json: @venue, status: :created, location: venue_url
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
    params.require(:venue).permit(:name, :status, :number_phones, :user)
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end
end