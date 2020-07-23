class HelpersController < ApplicationController
    def index

        if params[:foreman_id]
            @foreman = Foreman.find_by(id: params[:foreman_id])
            @helpers = @foreman.helpers

        else
            @helpers = Helper.all
        end

    end

    def show
        @helper = Helper.find_by(id: params[:id])
    end

    def new
        if params[:foreman_id] && Foreman.find_by(id: params[:foreman_id])
            redirect_to root_path
        else
            @helper = Helper.new(id: params[:foreman_id])
            @helper.build_user
            @helper.foreman = Foreman.find_by(id: params[:foreman_id])
        end
    end

    def create
        @helper = Helper.new(helper_params)
        @helper.build_user(helper_params[:user_attributes])
        if @helper.save
            redirect_to helper_path(@helper)
        else
            @helper
            render new_helper_path
        end
    end

    def edit
        @helper = Helper.find_by(id: params[:id])
    end

    def update
        @helper = Helper.find_by(id: params[:id])
        edit_helper_params
        @helper.update(foreman_id: helper_params[:foreman_id])
        @helper.user.update(helper_params[:user_attributes])
        @helper.save
        redirect_to helper_path(@helper)
    end

    def destroy
        Helper.find_by(params[:id]).destroy
        redirect_to root_path
    end

    private
    def helper_params
        params.require(:helper).permit(:user_id, :foreman_id, user_attributes: [:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number ])
    end

    def edit_helper_params
        params[:helper][:user_attributes].delete(:password) if params[:helper][:user_attributes][:password].blank?
        params[:helper][:user_attributes].delete(:password_confirmation) if params[:helper][:user_attributes][:password].blank? and params[:helper][:user_attributes][:password_confirmation].blank?


    end
end
