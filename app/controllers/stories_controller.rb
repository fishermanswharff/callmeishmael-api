class StoriesController < ApplicationController

  before_action :set_story, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create]

  def index
    stories = Story.all
    render json: stories, status: :ok
  end

  def show
    render json: @story, status: :ok
  end

  def create
    story = Story.create(story_params)
    if story.save
      render json: story, status: :created, location: story_url(story)
    else
      render json: story.errors, status: :unprocessable_entity
    end
  end

  def update
    if @story.update(story_params)
      render json: @story, status: :ok
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @story.destroy
    head :no_content
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :url, :story_type, :author_last, :author_first, :listens, :percentage)
  end

end
