class ButtonsController < ApplicationController

  def create
    button = Button.create!(button_params)
    if button.save
      render json: button, status: :created
    else
      render json: button.errors, status: :unprocessable_entity
    end
  end

  def update
    button = Button.find(params[:id])
    if button.update(button_params)
      render json: button, status: :ok
    else
      render json: button.errors, status: :unprocessable_entity
    end
  end

  def update_fixed
    buttons = Button.where(assignment: button_params[:assignment])
    story = Story.find(button_params[:story_id])
    Button.assign_story_by_assignment(story, button_params[:assignment])
    render json: buttons, status: :ok
  end

  def index_fixed
    buttons = Button.fixed_assignments
    render json: buttons, status: :ok
  end

  def index_star
    buttons = Button.star_assignments
    render json: buttons, status: :ok
  end

  def index_hash
    buttons = Button.hash_assignments
    render json: buttons, status: :ok
  end

  def index_zero
    buttons = Button.zero_assignments
    render json: buttons, status: :ok
  end

  def index_postroll
    buttons = Button.postroll_assignments
    render json: buttons, status: :ok
  end

  private

  def button_params
    params.require(:button).permit(:assignment, :phone_id, :story_id)
  end
end