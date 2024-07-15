module Api
  module V1
    module Errors
      class ParameterMissingError < Api::V1::Errors::Error
        attr_reader :param

        def initialize(error)
          super()

          unless error.is_a?(ActionController::ParameterMissing)
            raise "error must be an instance of ActionController::ParameterMissing"
          end

          @param = error.param
        end

        def status
          422
        end

        def title
          "parameter missing"
        end

        def detail
          "The specified 'param' must be included in the request."
        end

        def merge
          {param: @param}
        end
      end
    end
  end
end
