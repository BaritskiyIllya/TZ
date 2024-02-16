module Api
  module V1
    class DeviceExperimentsController < ApiController
      def index
        device = Device.find_or_create_by(token: request.headers['Device-Token'])
        render json: device, serializer: DeviceSerializer
      end
    end
  end
end

