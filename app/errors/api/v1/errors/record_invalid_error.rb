module Api
  module V1
    module Errors
      class RecordInvalidError < Api::V1::Errors::Error
        attr_reader :errors

        def initialize(error)
          super()

          unless error.is_a?(ActiveRecord::RecordInvalid)
            raise "error must be an instance of ActiveRecord::RecordInvalid"
          end

          @errors = ErrorSerializer.serialize(error.record.errors)
        end

        def status
          400
        end

        def title
          "record invalid"
        end

        def detail
          "The record is invalid."
        end

        def merge
          {validations: @errors}
        end
      end
    end
  end
end
