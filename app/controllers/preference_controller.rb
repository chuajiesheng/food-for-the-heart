class PreferenceController < ApplicationController
  before_action :authenticate_user!
  before_action :check_correct_user!

  def new
    current_user.preference = Preference.create
  end

  def edit

  end

  def update

  end

  private

  def check_correct_user!
    unless current_user.id == params[:id].to_i
      head(403)
    end
  end
end
