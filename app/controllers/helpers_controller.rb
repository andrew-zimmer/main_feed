class HelpersController < ApplicationController
    load_and_authorize_resource

    def contacts
        @helpers = Helper.all
    end

    def index
        set_index_instance_variable_based_on_route
    end

    def show
        @helper = find_helper_by_params
    end

    def new
        set_varibles_based_on_routes
    end

    def create
        user = User.create(helper_params[:user_attributes])
        @helper = user.build_helper(foreman_id: helper_params[:foreman_id])
        save_new_helper_else_redirect
    end

    def edit
        @helper = find_helper_by_params
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

    def find_helper_by_params
        Helper.find_by(id: params[:id])
    end

    def edit_helper_params
        params[:helper][:user_attributes].delete(:password) if params[:helper][:user_attributes][:password].blank?
        params[:helper][:user_attributes].delete(:password_confirmation) if params[:helper][:user_attributes][:password].blank? and params[:helper][:user_attributes][:password_confirmation].blank?
    end

    def find_foreman
        Foreman.find_by(id: params[:foreman_id])
    end

    def set_index_instance_variable_based_on_route
        if params[:foreman_id]
            @foreman = Foreman.find_by(id: params[:foreman_id])
            @helpers = @foreman.helpers
        else
            @helpers = Helper.all
        end
    end

    def set_varibles_based_on_routes
        if params[:foreman_id] && @foreman= Foreman.find_by(id: params[:foreman_id])
            @helper = @foreman.helpers.build
            @helper.build_user
        else
            @helper = Helper.new(foreman_id: params[:foreman_id])
            @helper.build_user
        end
    end

    def save_new_helper_else_redirect
        if @helper.save
            redirect_to helper_path(@helper)
        else
            @helper
            render new_helper_path
        end
    end

end
