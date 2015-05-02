class StoriesController < ApplicationController

  before_create :admin_only, only: [:create]

  def index
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

