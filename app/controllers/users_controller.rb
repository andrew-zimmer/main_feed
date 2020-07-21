class UsersController < ApplicationController
    load_and_authorize_resource

    def show
    end

    def index
    end

    def new
    end

    def create
    end

    def edit

            @user = User.find_by(id: params[:id])
            if @user.foreman
                @foreman = @user.foreman
            else
                @foreman = @user.build_foreman
            end
    end

    def update
        binding.pry
        user = User.find_by(id: params[:id])
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
        params[:user].delete(:foreman_attributes) if params[:user][:foreman_attributes][:user_id] != user.id
        user.update(user_params)

        user.save
        redirect_to root_path
    end

    def destroy
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number, foreman_attributes: [:user_id])
    end
end
