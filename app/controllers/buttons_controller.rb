class ButtonsController < ApplicationController

  def create
    binding.pry
    button = Button.create(button_params)
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

  private

  def button_params
    params.require(:button).permit(:assignment, :phone_id, :story_id)
  end
end