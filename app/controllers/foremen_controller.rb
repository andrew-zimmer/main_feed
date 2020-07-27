class ForemenController < ApplicationController
    load_and_authorize_resource

    def contacts
        @foremen = Foreman.all
    end

    def index
    end

    def show
        @foreman = Foreman.find_by_id(params[:id])
    end

    def new
        @foreman = Foreman.new
        @foreman.build_user
    end

    def create

        if foreman_params[:user_id].blank?
            params[:foreman].delete(:user_id)
            user = User.new(foreman_params[:user_attributes])
            user.save
            @foreman = user.build_foreman
            if @foreman.save
                redirect_to foreman_path(@foreman)
            else
                @foreman
                render new_foreman_path
            end
        else
            user = User.find_by(id: foreman_params[:user_id])
            user.helper.delete if !!user.helper
            if !!user.foreman || user.build_foreman.save
                redirect_to foreman_path(user.foreman)
            else
                @foreman = Foreman.new
                render new_foreman_path
            end
        end
    end

    def edit
        @foreman = find_foreman_with_params

    end

    def update

        foreman = find_foreman_with_params
        delete_password_attributes_from_params_if_not_present
        foreman.user.update(foreman_params[:user_attributes])

        foreman.save
        redirect_to foreman_path(foreman)
    end

    def destroy
        find_foreman_with_params.delete
        redirect_to foremen_path
    end

    private
    def foreman_params
        params.require(:foreman).permit(:user_id, user_attributes: [:first_name, :last_name, :role, :email, :password, :password_confirmation, :phone_number ])
    end

    def delete_password_attributes_from_params_if_not_present
        params[:foreman][:user_attributes].delete(:password) if params[:foreman][:user_attributes][:password].blank?
        params[:foreman][:user_attributes].delete(:password_confirmation) if params[:foreman][:user_attributes][:password].blank? and params[:foreman][:user_attributes][:password_confirmation].blank?
    end

    def find_foreman_with_params
        Foreman.find_by(id: params[:id])
    end

    def redirect_to_root
        redirect_to root_path
    end
end
