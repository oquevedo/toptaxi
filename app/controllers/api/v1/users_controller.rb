#API
module Api
  module V1
    class UsersController < BaseController
      skip_before_filter :restrict_access, only: [:create]
      respond_to :json


      def create
        @user = User.new(email: params[:email],password: params[:password], password_confirmation: params[:password_confirmation])
        if @user.save
          @user.slug = nil
          @user.save
          UserMailer.welcome(@user).deliver
          respond_with @user
        else
          return render text:"Ha ocurrido un error creando al usuario"
        end
      end
      def index
        return render nothing: true unless @user.admin
        respond_with User.all.map{|u| JSON.parse(u.to_json) }
      end

      def show
        
        respond_with @user ? User.find(@user.id) : User.find_by_email(params[:id])
      end

      def user_params
        params.require(:user).permit(:email,:first_name,:last_name,:password_confirmation, :password)
      end


    end
  end
end