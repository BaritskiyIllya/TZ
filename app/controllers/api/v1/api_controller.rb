module Api::V1
  class ApiController < ActionController::Base
    rescue_from Exception, with: :handle_exception

    before_action :current_device_set

    def current_device_set
      @current_device = Device.find_by_token(request.headers['Device-Token'])
    end

    def current_device
      @current_device
    end

    private

    def handle_exception exception
      if exception.instance_of? ActionController::ParameterMissing
        return render json: {:errors => { :exception => [exception.message]}}, status: :bad_request
      end

      if exception.instance_of? ActiveRecord::RecordNotFound
        return render json: {:errors => { :exception => [exception.message]}}, status: :not_found
      end

      exception.message.slice! 'Validation failed:' if exception.message.include?('Validation failed:')

      logger.fatal "API EXCEPTION: #{exception.to_s} \n     #{exception.backtrace.join("\n     ")}"
      render json: {:errors  => { :exception => [exception.message.strip]}}, status: :internal_server_error
    end
  end
end
