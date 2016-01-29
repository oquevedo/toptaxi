#API
module Api
  module V1
    class BaseController < ApplicationController
      before_filter :restrict_access
      skip_before_filter  :verify_authenticity_token

      def restrict_access
        access_token=request.headers["HTTP_ACCESS_TOKEN"] || params[:access_token]
        email=request.headers["HTTP_EMAIL"] || params[:email]
        password=request.headers["HTTP_PASSWORD"] || params[:password]
        if (access_token.present?)
          api_key = ApiKey.find_by_access_token(access_token)
          @user = api_key ? api_key.user : nil
          render_error_message "ApiKey no válida", :unauthorized unless @user
        elsif (email.present?)&&(password.present?)
          @user = User.authenticate(email, password)
          render_error_message "Usuario o contraseña erroneas", :unauthorized unless @user
        else
          render_error_message "No se enviaron parámetros para autentificar", :unauthorized
        end
      end

      def render_error_message message, status
        render json: {error: true, method: params[:action], message: message}.as_json, status: status
      end

      def render_need_param_error_msg param
        render json: {error: true, method: params[:action], message: "Falta el parámetro \'#{param}\'"}.as_json, status: :bad_request
      end


      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        render json: {error: true, message: "Falta el parámetro #{parameter_missing_exception.param}"}.as_json, status: :bad_request
      end
    end
  end
end
