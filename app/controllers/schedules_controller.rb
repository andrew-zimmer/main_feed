class SchedulesController < ApplicationController
    load_and_authorize_resource

    def show
    end

    def index
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def project_params
      params.require(:project).permit(:user_id, :project_id, :start_date, :end_date)
    end
end
