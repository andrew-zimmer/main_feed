class ForemenController < ApplicationController
    def index
    end

    def show
        @foreman = Foreman.find_by_id(params[:id])
    end

    def new
        if signed_in? && current_user.foreman
            @foreman = current_user.foreman
            @foreman.user
        else
            @foreman = Foreman.new
            @foreman.build_user
        end
    end

    def create

        if foreman_params[:user_id].blank?
            foreman = Foreman.new.build_user(foreman_params[:user_attributes])
            foreman.save
            redirect_to '/'
        else

            Foreman.create(foreman_params).save
            redirect_to '/'
        end
    end

    def edit

    end

    def update

    end

    private
    def foreman_params
        params.require(:foreman).permit(:user_id, user_attributes: [:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number ])
    end
end
