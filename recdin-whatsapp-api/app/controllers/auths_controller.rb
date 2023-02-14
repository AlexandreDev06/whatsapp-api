class AuthsController < ActionController::API
  def create_token
    password = params[:password]
    email = params[:email]
    user = User.find_by(email:, password:)
    if user.present?
      token = JWT.encode({ email:, password: }, Rails.application.secrets.secret_key_base, 'HS256')
      user.update!(access_token: token)
      render json: { access_token: token, expires_at: 'Never' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
