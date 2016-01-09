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
    @venue.users << User.find(params["venue"]["user_id"]) if params["venue"]["user_id"]
    if @venue.save
      render json: @venue, status: :created, location: venue_url(@venue)
    else
      render json: {errors: @venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if venue_params[:user_ids].present?
      venue_params[:user_ids].each { |user_id| @venue.users << User.find(user_id) }
    elsif venue_params[:story_ids].present?
      venue_params[:story_ids].each { |story_id| @venue.stories << Story.find(story_id) }
    end

    if @venue.update(venue_params)
      render json: @venue, status: :ok
    else
      render json: {errors: @venue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @venue.destroy
    head :no_content
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :status, :number_phones, :venue_status, user_ids: [], story_ids: [])
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end
end
