class UsersController < ApplicationController
    load_and_authorize_resource

    def contacts
        @users = User.all
    end

    def show
    end

    def index
    end


    def edit
        @user = User.find_by(id: params[:id])
        if @user.foreman
            @user.foreman
            @user.foreman.helpers.build
        elsif @user.helper
            @user.helper.build_foreman
            @user.helper
            @user.build_foreman
        else
            @user.build_foreman
            @user.build_helper
        end

    end

    def update

        @user = User.find_by(id: params[:id])
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

        if user_params[:foreman_attributes][:user_id] == '1'
            if @user.helper
                @user.helper.delete
            end
            @user.build_foreman
        elsif user_params[:helper_attributes][:user_id] == '1'
            if @user.foreman
                @user.foreman.delete
            end
            if @user.helper
                @user.helper.update(foreman_id: user_params[:helper_attributes][:foreman_id])
            else
                @user.build_helper(foreman_id: user_params[:helper_attributes][:foreman_id])
            end
        end
        params[:user].delete(:foreman_attributes)
        params[:user].delete(:helper_attributes)


        @user.update(user_params)
        if @user.save
            redirect_to root_path
        else
            @user
            render 'edit'
        end


    end

    def destroy
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number, foreman_attributes: [:user_id], helper_attributes: [:user_id, :foreman_id])
    end
end
