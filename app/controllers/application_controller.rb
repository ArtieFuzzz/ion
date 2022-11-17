class ApplicationController < ActionController::API
  def encode_tk(payload)
    JWT.encode(payload, Rails.application.credentials.jwt_secret)
  end

  def auth_header
    request.headers['authorization']
  end

  def decode_tk
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Rails.application.credentials.jwt_secret, true, algorithm: 'HS256')
      rescue 
        render json: {code: 2, message: 'You are not authorized to access this route'}, status: :unauthorized unless valid_token
      end
    end
  end

  def valid_token
    if decode_tk[0]['sub'] === 'artiefuzzz'
      return true
    end

    false
  end

  def authorized
    render json: {code: 2, message: 'You are not authorized to access this route'}, status: :unauthorized unless valid_token
  end
end
