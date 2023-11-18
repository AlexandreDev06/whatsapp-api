class ApplicationController < ActionController::API
  before_action :authenticate_user
  before_action :set_user
  skip_before_action :authenticate_user, only: [:welcome]

  def welcome
    render json: { status: 'Api running.', message: 'Check the repository for more information and docs. https://github.com/AlexandreDev06/whatsapp-api' }
  end

  private

  def authenticate_user
    token = request.headers['Authorization'].gsub('Bearer ', '')
    if token.present?
      begin
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })
        @current_user = User.find_by(email: decoded_token[0]['email'], password: decoded_token[0]['password'])
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    else
      render json: { error: 'Token not found' }, status: :unauthorized
    end
  end

  def set_user
    @user = User.first
  end
end
