class HelpersController < ApplicationController
    def index
        if params[:foreman_id]
            @helpers = Foreman.find_by(id: params[:foreman_id]).helpers
        else
            @helpers = Helper.all
        end

    end

    def show
        @helper = Helper.find_by(id: params[:id])
    end

    def new
        if params[:foreman_id] && Foreman.find_by(id: params[:foreman_id])
            redirect_to helper_new_path
        else
            @helper = Helper.new(id: params[:foreman_id])
            @helper.build_user
        end
    end

    def create
        if @helper = Helper.create(helper_params)
            redirect_to root_path
        else
            redirect_to new_helper_path
        end
    end

    private
    def helper_params
        params.require(:helper).permit(:user_id, :foreman_id, user_attributes: [:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number ])
    end
end
