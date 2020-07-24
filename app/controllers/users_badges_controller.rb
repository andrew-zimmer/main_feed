class UsersBadgesController < ApplicationController
    load_and_authorize_resource
    before_action :current_user_admin?

    def show
    end

    def index
        if params[:badge_id]
            @users_badges = UsersBadge.where(badge_id: params[:badge_id]).order(:full_name)

        else
            @users_badges = UsersBadge.all
        end
    end

    def new
        if params[:badge_id]
            @users_badge = Badge.find_by(id: params[:badge_id]).users_badges.build
        else
            @users_badge.build_badge
        end
    end

    def create
        params[:users_badge].delete(:badge_attributes) if users_badge_params[:badge_attributes][:issuer].blank? && users_badge_params[:badge_attributes][:issuer].blank?

        @users_badge = UsersBadge.new(users_badge_params)
        if @users_badge.save
            redirect_to users_badge_path(@users_badge)
        else
            render 'new'
        end
    end

    def edit

    end

    def update
        if @users_badge.update(users_badge_params)
            redirect_to users_badges_path
        else
            render 'edit'
        end
    end

    def destroy
        @users_badge.delete
        redirect_to users_badges_path
    end

    private
    def users_badge_params
        params.require(:users_badge).permit(:user_id, :badge_id, :expiration, badge_attributes: %i[issuer name])
    end


end
