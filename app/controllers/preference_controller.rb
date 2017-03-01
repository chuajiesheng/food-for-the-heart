class PreferenceController < ApplicationController
  before_action :authenticate_user!
  before_action :check_correct_user!

  def new
    unless current_user.preference
      current_user.preference = Preference.create
    end
    redirect_to preference_edit_user_path
  end

  def edit
    @preference = current_user.preference
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
