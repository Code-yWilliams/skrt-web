module Api
  module V1
    module Errors
      class RecordNotFoundError < Api::V1::Errors::Error
        attr_reader :errors

        def initialize(error)
          super()

          unless error.is_a?(ActiveRecord::RecordNotFound)
            raise "error must be an instance of ActiveRecord::RecordNotFound"
          end

          @error = error
        end

        def status
          404
        end

        def title
          "Not Found"
        end

        def detail
          @error.to_s
        end
      end
    end
  end
end
