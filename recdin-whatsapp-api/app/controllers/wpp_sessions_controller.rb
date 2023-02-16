class WppSessionsController < ApplicationController
  before_action :set_user, only: %i[create_session status_session]

  def create_session
    response = Whatsapp::SessionManager.new(@user).start_session
    render json: { message: response }, status: :ok
  end

  def status_session
    response = Whatsapp::SessionManager.new(@user).status_session
    render json: response.to_json, status: :ok
  end

  private

  def set_user
    @user = User.first
  end
end
