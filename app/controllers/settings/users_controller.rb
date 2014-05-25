class Settings::UsersController < ApplicationController
  include SettingsConcern
  before_action :set_user, only: %i[edit update]
  authorize_resource

  def edit    
    @provider_photo = {"provider" => ["default"],"photo_link" => [current_user.avatar]}
    
    OAuthCredential.where(user_id: current_user.id).each do |p|
      @provider_photo["provider"].push p.provider
      @provider_photo["photo_link"].push p.auth_hash["info"]["image"].gsub('http://','https://')+ "?width=250&height=250&type=square"
    end
  end

  def update
    if @user.update user_params
      redirect_to edit_settings_user_path, notice: t('crud.updated_successfully!', name: '')
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :about, :homepage, :avatar, :photo_provider)
  end

  def set_user
    @user = current_user
  end
end
