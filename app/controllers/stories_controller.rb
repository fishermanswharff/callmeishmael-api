class StoriesController < ApplicationController

  before_filter :admin_only, only: [:create]

  def index
    stories = Story.all
    render json: stories, status: :ok
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

end

