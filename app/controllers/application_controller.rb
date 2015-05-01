class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  def admin_only
    authenticate
    unless @current_user.admin?
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {
        error: 'You are not an admin'
      }, status: 403
    end
  end

  private

  def record_not_found
    render json: { error: 'Record Not Found'}, status: 404
  end
end
