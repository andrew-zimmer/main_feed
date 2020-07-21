class UsersController < ApplicationController
    def show
    end

    def index
    end

    def new
    end

    def create
    end

    def edit
        if current_user.admin?
            @user = User.find_by(id: params[:id])
        else
            redirect_to root_path
        end
    end

    def update

        user = User.find_by(id: params[:id])
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

        user.update(user_params)

        user.save
        redirect_to root_path
    end

    def destroy
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation)
    end
end
