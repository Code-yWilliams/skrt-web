module ApiAuthenticator
  extend ActiveSupport::Concern

  included do
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    # include ActionController::HttpAuthentication::Token::ControllerMethods
    include ActionController::Cookies
    include Pundit::Authorization

    before_action :authenticate_user!

    def authenticate_user!
      user_from_cookie! || authenticate_user_from_token! || raise(Api::V1::Errors::UnauthorizedError)
    end

    def user_from_cookie!
      return false unless request.env["warden"].session_serializer.stored?(:user)

      user = request.env["warden"].authenticate(scope: :user)
      if user.present?
        @current_user = user
        return true
      end

      false
    end

    def authenticate_user_from_token!
      authenticated = authenticate_with_http_basic do |email, auth_token|
        email = sanitize_email(email)
        user = User.find_by(email: email)

        if valid_user?(user, auth_token)
          @current_user = user
          user.track_last_seen!
          true
        else
          false
        end
      end

      return true if authenticated

      @current_user = nil
      false
    end

    def valid_user?(user, auth_token)
      user.present? && Devise.secure_compare(user.mobile_auth_token, auth_token)
    end

    def sanitize_email(email)
      email&.downcase&.force_encoding("UTF-8")&.scrub
    end
  end
end
