class UsersBadgesController < ApplicationController
    load_and_authorize_resource

    def show
    end

    def index
        index_route_nested_or_not
    end

    def new
        new_route_nested?
    end

    def create
        params[:users_badge].delete(:badge_attributes) if users_badge_params[:badge_attributes][:issuer].blank? && users_badge_params[:badge_attributes][:issuer].blank?

        @users_badge = UsersBadge.new(users_badge_params)
        new_users_badge_save_redirect
    end

    def edit
    end

    def update
        users_badge_update_redirect
    end

    def destroy
        @users_badge.delete
        redirect_to users_badges_path
    end

    private
    def users_badge_params
        params.require(:users_badge).permit(:user_id, :badge_id, :expiration, badge_attributes: %i[issuer name])
    end

    def index_route_nested_or_not
        if params[:badge_id]
            @users_badges = UsersBadge.where(badge_id: params[:badge_id]).order(:full_name)

        else
            @users_badges = UsersBadge.all
        end
    end

    def new_route_nested?
        if params[:badge_id]
            @users_badge = Badge.find_by(id: params[:badge_id]).users_badges.build
        elsif params[:user_id]
            @users_badge = User.find_by(id: params[:user_id]).users_badges.build
            @users_badge.build_badge
        else
            @users_badge.build_badge
        end
    end

    def new_users_badge_save_redirect
        if @users_badge.save
            redirect_to users_badge_path(@users_badge)
        else
            render 'new'
        end
    end

    def users_badge_update_redirect
        if @users_badge.update(users_badge_params)
            redirect_to users_badges_path
        else
            render 'edit'
        end
    end

end
