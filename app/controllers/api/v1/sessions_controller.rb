module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate_user!, only: [:create]

      # POST /api/v1/sessions
      def create
        user = User.find_by!(email: params[:email]&.downcase)
        validate_password!(user, params[:password])

        user.track_last_seen!

        # only allowed users can get access to the API
        authorize user, :create_auth_tokens?

        user_session = get_user_session!(user)

        render(json: user_session)
      rescue ActiveRecord::RecordNotFound
        raise Api::V1::Errors::LoginFailedError
      end

      # DELETE /api/v1/sessions
      def destroy
        user = @current_user
        authorize user, :destroy_auth_tokens?
        user.update!(
          mobile_auth_token: nil
        )
        render(json: {status: "OK"}, status: :ok)
      end

      # GET /api/v1/authenticate_access_token
      def authenticate_access_token
        render(json: {authenticated: true}, status: :ok)
      end

      private

      def validate_password!(user, password)
        raise Api::V1::Errors::LoginFailedError unless user.valid_password?(password)
      end

      def get_user_session!(user)
        {
          user: {
            email: user.email,
            mobile_auth_token: user.mobile_auth_token,
          }
        }
      end
    end
  end
end
