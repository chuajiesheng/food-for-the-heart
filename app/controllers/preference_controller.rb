class PreferenceController < ApplicationController
  before_action :authenticate_user!
  before_action :check_correct_user!

  ACCEPTABLE_PREFERENCE_ATTRIBUTES = [:chicken, :mutton, :beef, :fish, :prawn, :squid]

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
    if current_user.preference.update(params[:preference].permit(ACCEPTABLE_PREFERENCE_ATTRIBUTES))
      flash[:notice] = 'Preference updated'
    end
  end

  private

  def check_correct_user!
    unless current_user.id == params[:id].to_i
      head(403)
    end
  end
end
