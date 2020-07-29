class UsersController < ApplicationController
    load_and_authorize_resource

    def contacts
        @users = User.all.order_by_name
    end

    def show
    end

    def index
    end


    def edit
        @user = find_user_from_params_id
        edit_action_varibles_based_on_user_job
    end

    def update

        @user = find_user_from_params_id
        delete_params_that_arent_present
        build_foreman_or_helper_if_checked
        delete_foreman_and_helper_attr
        @user.update(user_params)
        save_user_or_redirect
    end

    def destroy
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number, foreman_attributes: [:user_id], helper_attributes: [:user_id, :foreman_id])
    end

    def find_user_from_params_id
        User.find_by(id: params[:id])
    end

    def edit_action_varibles_based_on_user_job
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

    def delete_params_that_arent_present
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    end

    def build_foreman_or_helper_if_checked
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
    end

    def delete_foreman_and_helper_attr
        params[:user].delete(:foreman_attributes)
        params[:user].delete(:helper_attributes)
    end

    def save_user_or_redirect
        if @user.save
            redirect_to user_path(@user)
        else
            @user
            render 'edit'
        end
    end



end
