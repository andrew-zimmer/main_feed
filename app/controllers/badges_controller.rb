class BadgesController < ApplicationController
    before_action :current_user_admin?

    def show
        @badge = Badge.find_by(id: params[:id])
    end

    def index
        @badges = Badge.all
    end

    def new
        @badge = Badge.new
    end

    def create
        @badge = Badge.new(badge_params)
        if @badge.save
            redirect_to badge_path(@badge)
        else
            render new_badge_path
        end
    end

    def edit
        @badge = Badge.find_by(id: params[:id])
    end

    def update
        @badge = Badge.find_by(id: params[:id])
        @badge.update(badge_params)
        if @badge.save
            redirect_to badge_path(@badge)
        else
            render 'edit'
        end
    end

    def destroy
        Badge.find_by(id: params[:id]).destroy
        redirect_to badges_path
    end

    private
    def badge_params
        params.require(:badge).permit(:issuer, :name)
    end
end
