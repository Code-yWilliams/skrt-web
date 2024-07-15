module Api
  module V1
    module Errors
      class UnauthorizedError < Api::V1::Errors::Error
        def status
          401
        end

        def title
          "unauthorized"
        end

        def detail
          "This user is not authorized."
        end
      end
    end
  end
end
