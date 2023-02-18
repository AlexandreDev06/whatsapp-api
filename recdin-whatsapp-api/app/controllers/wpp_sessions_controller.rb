class WppSessionsController < ApplicationController
  def create_session
    response = Whatsapp::SessionManager.new(@user).start_session
    render json: { message: response }, status: :ok
  end

  def status_session
    response = Whatsapp::SessionManager.new(@user).status_session
    render json: response.to_json, status: :ok
  end

  def close_session
    response = Whatsapp::SessionManager.new(@user).close_session
    render json: response.to_json, status: :ok
  end
end
