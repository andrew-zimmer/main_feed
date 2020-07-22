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
        @foreman = Foreman.find_by(id: params[:id])
    end

    def update

        foreman = Foreman.find_by(id: params[:id])
        delete_password_attributes_if_not_present
        foreman.user.update(foreman_params[:user_attributes])

        foreman.save
        redirect_to foreman_path(foreman)
    end

    def destroy

    end

    private
    def foreman_params
        params.require(:foreman).permit(:user_id, user_attributes: [:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number ])
    end

    def delete_password_attributes_if_not_present
        params[:foreman][:user_attributes].delete(:password) if params[:foreman][:user_attributes][:password].blank?
        params[:foreman][:user_attributes].delete(:password_confirmation) if params[:foreman][:user_attributes][:password].blank? and params[:foreman][:user_attributes][:password_confirmation].blank?

    end
end
