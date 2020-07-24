class BadgesController < ApplicationController
    load_and_authorize_resource

    def show
        badge_by_id
    end

    def index
        @badges = Badge.all
    end

    def new
        @badge = Badge.new
    end

    def create
        @badge = Badge.new(badge_params)
        save_new_badge_or_redirect
    end

    def edit
        badge_by_id
    end

    def update
        @badge = Badge.find_by(id: params[:id])
        update_badge_or_redirect
    end

    def destroy
        Badge.find_by(id: params[:id]).destroy
        redirect_to badges_path
    end

    private
    def badge_params
        params.require(:badge).permit(:issuer, :name)
    end

    def badge_by_id
        @badge = Badge.find_by(id: params[:id])
    end

    def save_new_badge_or_redirect
        if @badge.save
            redirect_to badge_path(@badge)
        else
            render new_badge_path
        end
    end

    def update_badge_or_redirect
        if @badge.update(badge_params)
            redirect_to badge_path(@badge)
        else
            render 'edit'
        end
    end
end
