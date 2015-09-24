class StoriesController < ApplicationController

  before_action :set_story, only: [:show, :update, :destroy]
  before_filter :admin_only, only: [:create, :update]

  def index
    stories = Story.all
    response = {
      stories: stories,
      number_ishmael_stories: Story.ishmaels_library.count,
      ishmael_listens: Story.listens_to_ishmaels_library,
      number_venue_stories: Story.all_venue_library.count,
      venue_listens: Story.listens_to_venue_library,
      number_postroll_stories: Story.postroll_library.count,
      postroll_listens: Story.listens_to_postrolls
    }.to_json
    render json: response, status: :ok
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
    params.require(:story).permit(:title, :url, :story_type, :author_last, :author_first, :listens, :percentage, :call_length, :common_title, :call_date, :spoiler_alert, :child_appropriate, :explicit, :gender, :rating, :transcript_url, :call_uuid)
  end

end

