module Api
  module V1
    class TestController < ApiController
      def index
        authorize :test, :index?
        render(json: {status: "OK"}, status: :ok)
      end
    end
  end
end
