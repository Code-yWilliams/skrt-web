module Api
  module V1
    module Errors
    class LoginFailedError < Api::V1::Errors::Error
        def status
          401
        end

        def title
          "login failed"
        end

        def detail
          "Email / password combindation is incorrect."
        end
      end
    end
  end
end
