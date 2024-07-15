module Api
  module V1
    class ApiController < ActionController::API
      include ApiAuthenticator
      include Pundit::Authorization

      respond_to :json

      rescue_from ActionController::ParameterMissing, with: :render_parameter_missing_error
      rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_error

      # Use our own not authorized error when Pundit errors
      rescue_from Pundit::NotAuthorizedError, with: :render_not_authorized_error

      # Coerce any Api::V1::Errors::Error to a response the client can deal with
      rescue_from Api::V1::Errors::Error, with: :render_error

      # Custom generic errors should be handled as well
      rescue_from ::Errors::Error, with: :render_error

      def render_error(error)
        render(json: error, status: error.status || 500)
      end

      def render_parameter_missing_error(error)
        render_error(Api::V1::Errors::ParameterMissingError.new(error))
      end

      def render_record_invalid_error(error)
        render_error(Api::V1::Errors::RecordInvalidError.new(error))
      end

      def render_record_not_found_error(error)
        render_error(Api::V1::Errors::RecordNotFoundError.new(error))
      end

      def render_not_authorized_error(error)
        render_error(Api::V1::Errors::UnauthorizedError.new(error))
      end
    end
  end
end
