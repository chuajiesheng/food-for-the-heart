class MealController < ApplicationController
  before_action :authenticate_user!
  before_action :check_correct_user!

  def show
  end

  private

  def check_correct_user!
    unless current_user.id == params[:id].to_i
      head(403)
    end
  end
end
